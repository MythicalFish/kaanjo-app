class AddMissingIndexToReactions < ActiveRecord::Migration
  def change
    add_index :reactions, :created_at
  end
end
