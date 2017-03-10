require 'messagebird'

class CampaignsController < ApplicationController
  before_action :set_campaign, only: [
    :name, :edit, :update,
    :message, :preview, :schedule,
    :send_now, :destroy
  ]

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
    @mailing_lists = MailingList.where("user_id = #{current_user.id}")
  end

  def message
  end

  def preview
  end

  def schedule
  end

  def send_now
    mailing_list = @campaign.mailing_list
    contacts = mailing_list.contacts

    begin
      client = MessageBird::Client.new(ENV['MESSAGEBIRD_ACCESS_KEY'])
      contacts.each do |contact|
        contact.messagebird_ref = SecureRandom.base64.to_s
        client.message_create("+33649886416", contact.phone_number, @campaign.message, {
          reference: contact.messagebird_ref
        })
        contact.save!
      end
      @campaign.sent_at = DateTime.now
      @campaign.save!
      redirect_to :action => :index
    rescue Exception => ex
      raise ex.inspect
    end
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
      else
        redirect_to :action => :preview, :id => @campaign.id
      end

    when "step_3"

      @campaign.save

      if params[:commit] == "Enregistrer et quitter"
        redirect_to root_path
      else
        redirect_to :action => :schedule, :id => @campaign.id
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
end
