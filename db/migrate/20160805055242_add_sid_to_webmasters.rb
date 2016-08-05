class AddSidToWebmasters < ActiveRecord::Migration
  def up
    change_column :products, :sid, :string, null: false
    add_column :users, :sid, :string
    add_index :users, :sid
  end
  def down
    change_column :products, :sid, :string
    remove_column :users, :sid, :string
  end
end
