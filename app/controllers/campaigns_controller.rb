class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:name, :edit, :update, :message, :preview, :schedule, :destroy]
  def index
    not_sent = Campaign.where("sent_at is null and user_id = #{current_user.id}").order(:created_at)
    sent = Campaign.where("sent_at is not null and user_id = #{current_user.id}").order(:sent_at)
    @campaigns = not_sent + sent
  end

  def new
    @campaign = Campaign.new
    @campaign.user = current_user
    @campaign.save
    redirect_to :action => :name, :id => @campaign.id
  end

  def name
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
    if params[:campaign][:liste].present?
      @campaign.mailing_lists = [MailingList.find(params[:campaign][:liste])]
    end
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
      ).except(:liste)
  end
end
