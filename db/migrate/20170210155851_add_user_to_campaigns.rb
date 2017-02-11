class AddUserToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :user_id, :integer
  end
end
