class Campaign < ApplicationRecord
  has_many :mailing_lists, through: :campaigns_mailing_lists
end
