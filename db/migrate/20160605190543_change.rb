class Change < ActiveRecord::Migration
  def change
    rename_column :reactions, :type, :name
  end
end
