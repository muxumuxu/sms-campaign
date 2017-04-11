# Contact model
class Contact < ApplicationRecord
  acts_as_paranoid

  belongs_to :mailing_list
  validates :phone_number, presence: true, phony_plausible: true
  phony_normalize :phone_number, default_country_code: 'FR'
  default_scope -> { order(last_name: :ASC) }
end
