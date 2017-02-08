class Campaign < ApplicationRecord
  has_many :campaigns_mailing_lists
  has_many :mailing_lists, through: :campaigns_mailing_lists
  has_many :contacts, through: :mailing_lists
end
