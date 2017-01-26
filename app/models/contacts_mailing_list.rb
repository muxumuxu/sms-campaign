class ContactsMailingList < ApplicationRecord
  belongs_to :contact
  belongs_to :mailing_list
end
