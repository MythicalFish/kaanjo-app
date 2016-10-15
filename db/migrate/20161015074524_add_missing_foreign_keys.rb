class AddMissingForeignKeys < ActiveRecord::Migration
  def change

    add_column :impressions, :campaign_id, :integer, null: false
    add_index :impressions, :campaign_id

    add_column :reactions, :campaign_id, :integer, null: false
    add_index :reactions, :campaign_id

    add_column :customers, :campaign_id, :integer, null: false
    add_index :customers, :campaign_id

  end
end
