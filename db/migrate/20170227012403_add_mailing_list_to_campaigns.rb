class AddMailingListToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :mailing_list_id, :integer
    drop_table :campaigns_mailing_lists
  end
end
