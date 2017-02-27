class Campaign < ApplicationRecord
  belongs_to :mailing_list
  belongs_to :user
end
