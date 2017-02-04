class MailingListsController < ApplicationController
  def index
  end

  def new
    @mailing_list = MailingList.new
    @mailing_list.save
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
