class AddProductsCountToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :products_count, :integer
  end
end
