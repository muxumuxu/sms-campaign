class CampaignsController < ApplicationController
  before_action :set_campaign, only: [
    :name, :edit, :update,
    :message, :preview, :schedule, 
    :schedule_time, :send_now, :destroy
  ]

  def index
	  Campaign.where("name is null").destroy_all
    not_sent = Campaign.where("sent_at is null and user_id = #{current_user.id}").order(:created_at)
    sent = Campaign.where("sent_at is not null and user_id = #{current_user.id}").order(:sent_at)
    @campaigns = not_sent + sent
  end

  # GET /new
  def new
    @campaign = Campaign.new
    @campaign.user = current_user
    @campaign.save
    redirect_to :action => :name, :id => @campaign.id
  end

  def name
    @mailing_lists = MailingList.where("user_id = #{current_user.id}")
    @campaign.mailing_list = @mailing_lists.first if @campaign.mailing_list.nil?
  end

  def message
  end

  def preview
    # Here we must cancel all scheduled SMS
  end

  def schedule_time
    scheduled_at = @campaign[:scheduled_at]
    unless scheduled_at.nil?
      scheduled_at = scheduled_at.in_time_zone('CET')
      @day = scheduled_at.strftime("%d/%m/%Y")
      @start_hour = scheduled_at.hour
      @start_min = scheduled_at.min
    end
  end

  def schedule
    day = DateTime.parse(schedule_params[:scheduled_at])
    date = DateTime.new(
      day.year, day.month, day.day, 
      schedule_params[:start_hour].to_i, 
      schedule_params[:start_min].to_i, 0, 
      schedule_params[:tz])
    @campaign[:scheduled_at] = date
    @campaign.save!
    SendScheduledCampaignsJob.set(wait_until: date).perform_later @campaign
    redirect_to :action => :index
  end

  def send_now
    @campaign[:scheduled_at] = DateTime.now
    @campaign.save!
    @campaign.send_campaign()
    redirect_to :action => :index
  end

  def create
  end

  def edit
  end

  # Handle each step of the workflow
  def update

    # Validates fields are correctly filled
    case params[:campaign][:current_step]

    when "step_1"
      # Check if name exist
      if campaign_params[:name].blank?
        redirect_to :action => :name, :id => @campaign.id
        return
      end

      @campaign.name = campaign_params[:name]

      # Check if mailing list selected
      mailing_list_id = params[:campaign][:mailing_list]
      if mailing_list_id.blank?
        redirect_to :action => :name, :id => @campaign.id
        return
      end

      @campaign.mailing_list = MailingList.find(mailing_list_id)
      @campaign.save

      if params[:commit] == "Enregistrer et quitter"
        redirect_to root_path
      else
        redirect_to :action => :message, :id => @campaign.id
      end

    when "step_2"

      if campaign_params[:message].blank?
        redirect_to :action => :message, :id => @campaign.id
        return
      end

      @campaign.message = campaign_params[:message]
      @campaign.save

      if params[:commit] == "Enregistrer et quitter"
        redirect_to root_path
      elsif @campaign[:scheduled_at]
        redirect_to :action => :schedule_time
      else
        redirect_to :action => :preview, :id => @campaign.id
      end

    when "step_3"

      @campaign.save

      if params[:commit] == "Enregistrer et quitter"
        redirect_to root_path
      else
        redirect_to :action => :schedule_time, :id => @campaign.id
      end
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

  def schedule_params
    params.require(:campaign).permit(
      :scheduled_at, :start_hour, :start_min, :tz)
  end
end
