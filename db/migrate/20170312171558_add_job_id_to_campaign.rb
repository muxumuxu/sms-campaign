class AddJobIdToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :job_id, :string
  end
end
