class CreateReactionTypes < ActiveRecord::Migration
  def change
    create_table :reaction_types do |t|
      t.string :name, null: false
    end
  end
end
