class AlterReactionTypesName < ActiveRecord::Migration
  def change
    rename_column :reaction_types, :name, :label 
  end
end
