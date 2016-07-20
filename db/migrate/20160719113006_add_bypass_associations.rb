class AddBypassAssociations < ActiveRecord::Migration
  def change
    add_column :impressions, :webmaster_id, :integer, default: 0
    add_index :impressions, :webmaster_id
    add_column :reactions, :webmaster_id, :integer, default: 0
    add_index :reactions, :webmaster_id
  end
end
