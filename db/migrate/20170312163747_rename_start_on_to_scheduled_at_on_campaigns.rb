class RenameStartOnToScheduledAtOnCampaigns < ActiveRecord::Migration[5.0]
  def change
  	rename_column :campaigns, :start_on, :scheduled_at
  end
end
