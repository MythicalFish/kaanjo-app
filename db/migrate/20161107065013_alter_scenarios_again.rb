class AlterScenariosAgain < ActiveRecord::Migration
  def change
    rename_column :scenarios, :is_default, :enabled
  end
end
