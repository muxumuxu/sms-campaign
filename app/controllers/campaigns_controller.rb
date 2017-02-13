class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:name, :edit, :update, :message, :preview, :schedule, :destroy]

  def index
	  Campaign.where("name is null").destroy_all
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
  end

  def edit
  end

  def update

    # Validates fields are correctly filled
    case params[:campaign][:current_step]
    when "step_1"
      # Check if name exist
      if campaign_params[:name].blank?
        flash[:notice] = "You must provide a name"
        redirect_to :action => :name, :id => @campaign.id
        return
      end

      @campaign.name = campaign_params[:name]
      @campaign.save

      # Check if mailing list selected
      if params[:campaign][:liste].blank?
        flash[:notice] = "You must select a mailing list"
        redirect_to :action => :name, :id => @campaign.id
        return
      end

      @campaign.mailing_lists = [MailingList.find(params[:campaign][:liste])]
      @campaign.save

      redirect_to :action => :message, :id => @campaign.id
    when "step_2"
      if campaign_params[:message].blank?
        flash[:notice] = "You must provide a message"
        redirect_to :action => :message, :id => @campaign.id
        return
      end

      @campaign.message = campaign_params[:message]
      @campaign.save

      redirect_to :action => :preview, :id => @campaign.id
    # when "step_3"
    #   redirect_to :action => :schedule, :id => @campaign.id
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
      ).except(:liste).except(:current_step)
  end
end
