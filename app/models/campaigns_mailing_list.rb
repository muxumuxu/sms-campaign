class CampaignsMailingList < ApplicationRecord
  belongs_to :mailing_list
  belongs_to :campaigns
end
