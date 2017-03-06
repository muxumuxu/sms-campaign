require 'csv'

class MailingListsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_mailing_list, only: [
    :edit, :update, :show, :upload_csv, :import_csv_results, :destroy, :import_csv
  ]

  def index
    @mailing_lists = MailingList.where("user_id = #{current_user.id}")
  end

  def new
    @mailing_list = MailingList.new
    @mailing_list.user = current_user
    @mailing_list.save
  end

  def show
  end

  def create
    @mailing_list = MailingList.new(mailing_list_params)
    @mailing_list.user = current_user
    if @mailing_list.save
      if params[:mailing_list][:import_type] == "csv"
        redirect_to :action => :upload_csv, :id => @mailing_list.id
      else
        redirect_to :action => :index
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    @mailing_list.update(mailing_list_params)
    if @mailing_list.save
      redirect_to :action => :index
    else
      render :edit
    end
  end

  def upload_csv
  end

  def import_csv
    file_data = upload_file_params[:file]
    
    if file_data.respond_to?(:read)
      csv_contents = file_data.read
    elsif file_data.respond_to?(:path)
      csv_contents = File.read(file_data.path)
    else
      raise "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end

    CSV.parse(csv_contents) do |row|
      contact = Contact.where(phone_number: row[0], mailing_list_id: @mailing_list.id)
      contact = Contact.new if contact.nil? 
      
      contact = Contact.new
      contact.phone_number = row[0]
      contact.first_name = row[1]
      contact.last_name = row[2]
      contact.zip_code = row[3]
      contact.mailing_list_id = @mailing_list.id
      contact.save!
    end

    redirect_to :action => :index
  end

  def import_csv_results
  end

  def destroy
    @mailing_list.destroy
    redirect_to mailing_lists_path
  end

  private

  def set_mailing_list
    @mailing_list = MailingList.find(params[:id])
  end

  def mailing_list_params
    params.require(:mailing_list).permit(:name, :import_type).except(:import_type)
  end

  def upload_file_params
    params.require(:mailing_list).permit(:file)
  end
end
