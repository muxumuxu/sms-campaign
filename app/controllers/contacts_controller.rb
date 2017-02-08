class ContactsController < ApplicationController
  before_action :set_contact, only: [:edit, :update, :destroy]
  def new
    @contact = Contact.new
    @contact.mailing_lists = [MailingList.find(params[:mailing_list_id])]
  end

  def create
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
end
