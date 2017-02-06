class ContactsMailingList < ApplicationRecord
  belongs_to :mailing_list
  belongs_to :contact
end
