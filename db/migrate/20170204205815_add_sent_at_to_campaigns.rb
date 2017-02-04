class AddSentAtToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :sent_at, :datetime
  end
end
