# Mailing List class
class MailingList < ApplicationRecord
  acts_as_paranoid

  has_many :contacts, dependent: :destroy
  has_many :campaigns
  validates :name, presence: true
  default_scope -> { order(name: :ASC) }
  belongs_to :user

  scope :by_user, lambda { |user|
    where("user_id = #{user.id}")
  }
end
