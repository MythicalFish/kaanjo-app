class AddDeviceTypeToImpressions < ActiveRecord::Migration
  def change
    add_column :impressions, :device_type, :string
    add_column :reactions, :device_type, :string
    add_index :impressions, :device_type
    add_index :reactions, :device_type
  end
end
