class AddDeletedAtToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :deleted_at, :datetime
    add_index :campaigns, :deleted_at
  end
end
