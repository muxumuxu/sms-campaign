class SendScheduledCampaignsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    campaigns = Campaign.where("scheduled_at is not null AND sent_at is null")
    
  end
end
