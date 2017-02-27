class MailingList < ApplicationRecord
  has_many :contacts
  has_many :campaigns
  validates :name, presence: true
  default_scope -> { order(name: :ASC) }
  belongs_to :user
end
