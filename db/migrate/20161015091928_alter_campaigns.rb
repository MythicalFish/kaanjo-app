class AlterCampaigns < ActiveRecord::Migration
  def up
    change_column :campaigns, :webmaster_id, :integer, default: 0
  end
  def down
  end
end
