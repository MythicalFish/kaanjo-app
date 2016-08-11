class AddMessageToReactionTypes < ActiveRecord::Migration
  def change
    add_column :reaction_types, :message, :string, default: 'Thanks! You and {number} others feel this way.'
    add_column :reaction_types, :message_first, :string, default: 'Thanks! You are the first to feel this way.'
  end
end
