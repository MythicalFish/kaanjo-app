class AddAttributesToReactions < ActiveRecord::Migration
  def change

    remove_column :reactions, :updated_at, :datetime

    add_column :reactions, :reaction_type_id, :integer, :null => false
    add_index :reactions, :reaction_type_id

    add_column :reactions, :webmaster_id, :integer, :null => false
    add_index :reactions, :webmaster_id

    add_column :reactions, :customer_id, :integer, :null => false
    add_index :reactions, :customer_id

    add_column :reactions, :product_url, :string, :null => false
    add_index :reactions, :product_url

    add_column :reactions, :product, :string, :null => false
    add_index :reactions, :product

    remove_column :reactions, :name, :string
    remove_column :reactions, :referrer, :string

  end
end
