class RemoveCampaignIdFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :campaign_id
  end
end
