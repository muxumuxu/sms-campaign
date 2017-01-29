class CampaignsController < ApplicationController
  def index
  end

  def new
    @campaign = Campaign.new
    @mailing_lists = MailingList.all
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
