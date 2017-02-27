class AddMailingListToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :mailing_list_id, :integer
    drop_table :contacts_mailing_lists
  end
end
