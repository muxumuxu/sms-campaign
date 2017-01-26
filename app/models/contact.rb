class Contact < ApplicationRecord
  has_many :mailing_lists, through: :contacts_mailing_lists
  validates :phone_number, presence: true
end
