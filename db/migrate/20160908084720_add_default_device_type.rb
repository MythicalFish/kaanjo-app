class AddDefaultDeviceType < ActiveRecord::Migration
  def change
    change_column :impressions, :device_type, :string, :default => 'Unknown'
    change_column :reactions, :device_type, :string, :default => 'Unknown'
  end
end
