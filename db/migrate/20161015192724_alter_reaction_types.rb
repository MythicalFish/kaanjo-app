class AlterReactionTypes < ActiveRecord::Migration
  def change
    add_attachment :reaction_types, :emoticon
  end
end
