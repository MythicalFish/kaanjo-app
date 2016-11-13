class RestoreReactionForeignKeys < ActiveRecord::Migration
  def change
    add_column :reactions, :product_id, :integer, null: false
    add_column :reactions, :customer_id, :integer, null: false
    add_index :reactions, :customer_id
    add_index :reactions, :product_id
  end
end
