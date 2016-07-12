class CreateImpressionsAndProducts < ActiveRecord::Migration
  def change
    
    create_table :impressions do |t|
      t.integer :product_id, null: false
      t.integer :customer_id, null: false
      t.datetime :created_at, null: false
    end

    add_index :impressions, :product_id
    add_index :impressions, :customer_id
    add_index :impressions, :created_at

    create_table :products do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.integer :webmaster_id, null: false
      t.datetime :created_at, null: false
    end

    add_index :products, :name
    add_index :products, :webmaster_id
    add_index :products, :created_at

    remove_column :reactions, :product, :string
    remove_column :reactions, :product_url, :string
    remove_column :reactions, :webmaster_id, :integer

    add_column :reactions, :product_id, :integer
    add_index :reactions, :product_id

  end
end
