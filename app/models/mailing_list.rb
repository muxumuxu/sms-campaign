class MailingList < ApplicationRecord
  has_many :contacts_mailing_lists
  has_many :contacts, through: :contacts_mailing_lists
  has_many :campaigns_mailing_lists
  has_many :campaigns, through: :campaigns_mailing_lists
  validates :name, presence: true
end
