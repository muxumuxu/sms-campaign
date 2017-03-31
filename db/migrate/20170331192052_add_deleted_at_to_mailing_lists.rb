class AddDeletedAtToMailingLists < ActiveRecord::Migration[5.0]
  def change
    add_column :mailing_lists, :deleted_at, :datetime
    add_index :mailing_lists, :deleted_at
  end
end
