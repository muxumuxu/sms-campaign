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
    @mailing_list = MailingList.new(mailing_list_params)
    if @campaign.save
      redirect_to :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    @mailing_list.update(mailing_list_params)
    if @mailing_list.save
      redirect_to :index
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def set_mailing_list
    @mailing_list = MailingList.find(params[:id])
  end

  def mailing_list_params
    params.require(:mailing_list).permit(
      :name
      )
  end
end
