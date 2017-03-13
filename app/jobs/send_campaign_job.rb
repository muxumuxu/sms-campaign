class SendCampaignJob < ApplicationJob
  queue_as :default

  def perform(campaign_id)

  	puts "Starting jon for #{campaign_id}"
  	campaign = Campaign.find(campaign_id)
  	return unless campaign.sent_at.nil?
  	return if campaign.scheduled_at.nil?
  	
    campaign.send_campaign()
  end
end
