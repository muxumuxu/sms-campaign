class ContactsController < ApplicationController
  before_action :set_contact, only: [:edit, :update, :destroy]
  before_action :set_mailing_list, only: [:create]
  def new
    @contact = Contact.new
    @contact.mailing_lists = [ MailingList.find(params[:mailing_list_id]) ]
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to @mailing_list
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def set_mailing_list
    @mailing_list = MailingList.find(params[:mailing_list_id])
  end

  def contact_params
    params.require(:contact).permit(
      :phone_number,
      :first_name,
      :last_name,
      :zip_code,
      :mailing_list_id
      )
  end
end
