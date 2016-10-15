class AlterCampaigns < ActiveRecord::Migration
  def up
    change_column :campaigns, :webmaster_id, :integer, default: 0
    rename_column :campaigns, :title, :name
  end
  def down
  end
end
