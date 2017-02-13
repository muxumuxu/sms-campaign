class AddUserToMailingLists < ActiveRecord::Migration[5.0]
  def change
    add_column :mailing_lists, :user_id, :integer
  end
end
