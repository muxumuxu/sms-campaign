class CreateContactsMailingLists < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts_mailing_lists do |t|
      t.references :contact, foreign_key: true
      t.references :mailing_list, foreign_key: true

      t.timestamps
    end
  end
end
