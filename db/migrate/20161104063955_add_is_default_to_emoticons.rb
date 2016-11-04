class AddIsDefaultToEmoticons < ActiveRecord::Migration
  def change
    add_column :emoticons, :is_default, :boolean, default: false
    add_index :emoticons, :is_default
    add_index :campaigns, :deleted
    add_index :users, :admin
  end
end
