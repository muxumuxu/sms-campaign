class Contact < ApplicationRecord
  has_many :mailing_lists, through: :contacts_mailing_lists
  validates :phone_number, presence: true, phony_plausible: true
  phony_normalize :phone_number, default_country_code: 'FR'
end
