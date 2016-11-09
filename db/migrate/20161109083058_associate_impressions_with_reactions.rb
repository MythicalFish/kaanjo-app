class AssociateImpressionsWithReactions < ActiveRecord::Migration
  def up
    add_column :reactions, :impression_id, :integer, null: false
    add_index :reactions, :impression_id
  end
  def down
    remove_column :reactions, :impression_id
  end
end
