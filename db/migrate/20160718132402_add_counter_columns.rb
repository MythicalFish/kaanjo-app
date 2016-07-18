class AddCounterColumns < ActiveRecord::Migration
  def change
    
    add_column :products, :impressions_count, :integer, default: 0
    add_index :products, :impressions_count
    
    add_column :products, :reactions_count, :integer, default: 0
    add_index :products, :reactions_count
    
    Product.all.each do |p|
      Product.reset_counters(p.id,:impressions)
    end
    

  end
end
