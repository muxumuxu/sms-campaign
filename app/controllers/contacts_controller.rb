class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @contact = Contact.new
    @mailing_list_id = params[:mailing_list_id]
  end

  def create
    mailing_list_id = params[:contact][:mailing_list_id]
    phone = contact_params[:phone_number]
    @contact = Contact.where(phone_number: phone, mailing_list_id: mailing_list_id).first
    @contact = Contact.new() if @contact.nil?
    @contact.update(contact_params)
    mailing_list = MailingList.find(mailing_list_id)
    @contact.mailing_list = mailing_list
    if @contact.save
      redirect_to mailing_list
    else
      render :new
    end
  end

  def edit
  end

  def import
    # Import from CSV file
    uploaded_file = params[:file]
    
  end

  def update
    @contact.update(contact_params)
    if @contact.save
      redirect_to @contact
    else
      render :edit
    end
  end

  def destroy
    mailing_list = @contact.mailing_list
    @contact.destroy
    redirect_to mailing_list_path(mailing_list)
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(
      :phone_number,
      :first_name,
      :last_name,
      :zip_code
      ).except(:mailing_list_id)
  end
end
