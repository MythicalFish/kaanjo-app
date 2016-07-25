class AddSomeThings < ActiveRecord::Migration
  def change

    add_column :customers, :browser, :string
    add_column :customers, :device, :string
    add_column :customers, :ip_address, :string
    add_column :customers, :location, :string

    add_index :customers, :browser
    add_index :customers, :device
    add_index :customers, :ip_address
    add_index :customers, :location

  end
end
