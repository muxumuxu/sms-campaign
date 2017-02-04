class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:campaign_name, :edit, :update, :message, :preview, :schedule, :destroy]
  def index
  end

  def new
    @campaign = Campaign.new
    @campaign.save
    redirect_to :action => :campaign_name, :id => @campaign.id
  end

  def campaign_name
    @mailing_lists = MailingList.all
  end

  def message
  end

  def preview
  end

  def schedule
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      redirect_to :action => :message, :id => @campaign.id
    else
      render :new
    end
  end

  def edit
  end

  def update
    @campaign.update(campaign_params)
    if campaign_params[:name].present?
      redirect_to :action => :message, :id => @campaign.id
    else
      redirect_to :action => :preview, :id => @campaign.id
    end
  end

  def destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def campaign_params
    params.require(:campaign).permit(
      :name, :message
      )
  end
end
