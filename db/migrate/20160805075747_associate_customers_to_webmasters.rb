class AssociateCustomersToWebmasters < ActiveRecord::Migration
  def change
    add_column :customers, :webmaster_id, :integer, null: false
    add_index :customers, :webmaster_id
  end
end
