class RenameReactionTypesToScenarios < ActiveRecord::Migration
  def change
    rename_table :reaction_types, :scenarios
    rename_column :reactions, :reaction_type_id, :scenario_id
  end
end
