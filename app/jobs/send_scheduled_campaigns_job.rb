class SendScheduledCampaignsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    raise args.inspect
  end
end
