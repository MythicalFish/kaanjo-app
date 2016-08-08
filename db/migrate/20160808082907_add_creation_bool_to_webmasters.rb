class AddCreationBoolToWebmasters < ActiveRecord::Migration
  def change
    add_column :users, :creation_enabled, :boolean, default: true
  end
end
