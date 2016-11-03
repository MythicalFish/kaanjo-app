class FixReactionTypeAssociations < ActiveRecord::Migration
  def change
    add_column :reaction_types, :campaign_id, :integer
    add_index :reaction_types, :campaign_id
    drop_table :campaigns_reaction_types
  end
end
