class AlterReactionsAndImpressions < ActiveRecord::Migration
  def up
    remove_column :reactions, :device_type
    remove_column :reactions, :customer_id
    remove_column :reactions, :product_id
    change_column :impressions, :device_type, :string, default: "Not given"
  end
  def down
    add_column :reactions, :device_type, :string
  end
end
