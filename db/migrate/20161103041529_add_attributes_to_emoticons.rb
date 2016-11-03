class AddAttributesToEmoticons < ActiveRecord::Migration
  def change
    rename_column :emoticons, :default_label, :label
    add_column :emoticons, :message, :string 
  end
end
