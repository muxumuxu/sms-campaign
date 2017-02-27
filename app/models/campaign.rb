class Campaign < ApplicationRecord
  has_one :mailing_list
  belongs_to :user
end
