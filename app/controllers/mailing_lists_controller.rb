class MailingListsController < ApplicationController
  before_action :set_mailing_list, only: [:edit, :update, :show, :destroy]
  def index
    @mailing_lists = MailingList.all
  end

  def new
    @mailing_list = MailingList.new
    @mailing_list.save
  end

  def show
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

  def set_mailing_list
    @mailing_list = MailingList.find(params[:id])
  end
end
