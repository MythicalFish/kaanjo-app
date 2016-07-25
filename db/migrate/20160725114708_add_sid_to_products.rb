class AddSidToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sid, :string
    add_index :products, :sid
  end
end
