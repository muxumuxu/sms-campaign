class CampaignsMailingList < ApplicationRecord
  belongs_to :campaign
  belongs_to :mailing_list
end
