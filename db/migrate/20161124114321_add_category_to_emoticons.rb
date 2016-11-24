class AddCategoryToEmoticons < ActiveRecord::Migration
  def change
    add_column :emoticons, :category, :string
    add_index :emoticons, :category
  end
end
