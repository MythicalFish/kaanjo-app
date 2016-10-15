class CreateEmoticons < ActiveRecord::Migration
  def change
    
    create_table :emoticons do |t|
      t.string :default_label, null: false
      t.attachment :image
      t.string :sid, null: false
    end

    add_index :emoticons, :default_label
    add_index :emoticons, :sid

    add_column :reaction_types, :emoticon_id, :integer
    add_index :reaction_types, :emoticon_id

    add_column :reaction_types, :is_default, :boolean, default: false
    add_index :reaction_types, :is_default

  end
end
