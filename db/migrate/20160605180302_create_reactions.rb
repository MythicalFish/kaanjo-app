class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.integer :type
      t.string :referer

      t.timestamps null: false
    end
    add_index :reactions, :type
    add_index :reactions, :referer
  end
end
