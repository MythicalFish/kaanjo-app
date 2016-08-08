class RemoveDeprecated < ActiveRecord::Migration
  def change
    remove_column :customers, :device
    remove_column :customers, :browser
    remove_column :customers, :location
    remove_column :customers, :ip
  end
end
