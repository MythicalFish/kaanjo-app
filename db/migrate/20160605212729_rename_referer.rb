class RenameReferer < ActiveRecord::Migration
  def change
    rename_column :reactions, :referer, :referrer
  end
end
