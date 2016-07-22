class AddStuff < ActiveRecord::Migration
  def change
    rename_column :users, :website, :website_url
    add_column :users, :website_name, :string
  end
end
