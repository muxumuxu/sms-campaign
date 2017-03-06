class MailingList < ApplicationRecord
  has_many :contacts, dependent: :destroy
  has_many :campaigns
  validates :name, presence: true
  default_scope -> { order(name: :ASC) }
  belongs_to :user
end
