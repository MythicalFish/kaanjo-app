class RestructureAssociations < ActiveRecord::Migration
  def up

    remove_column :customers, :webmaster_id
    add_column :customers, :campaign_id

    remove_column :impressions, :webmaster_id
    remove_column :impressions, :campaign_id

    add_column :products, :campaign_id, :integer, null: false
    add_index :products, :campaign_id
    remove_column :products, :webmaster_id

    remove_column :reactions, :webmaster_id
    remove_column :reactions, :campaign_id

  end
end
