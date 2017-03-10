class AddMessageBirdRefToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :messagebird_ref, :string
  end
end
