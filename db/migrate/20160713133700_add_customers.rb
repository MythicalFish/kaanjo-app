class AddCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :sid, null: false
      t.string :ip, null: false
    end
    add_index :customers, :sid
  end
end
