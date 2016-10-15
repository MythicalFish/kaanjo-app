class CreateCampaigns < ActiveRecord::Migration
  def change
    drop_table :campaigns if (table_exists? :campaigns)
    create_table :campaigns do |t|
      t.integer :relative_id, null: false
      t.references :webmaster
      t.string :title
      t.text :description
      t.string :site_path
      t.boolean :enabled, default: false 
      t.date :start_date
      t.date :end_date
      t.string :question
      t.boolean :is_default, default: false
      t.timestamps
    end
    add_index :campaigns, :created_at unless (index_exists? :campaigns, :created_at)
    add_index :campaigns, :webmaster_id unless (index_exists? :campaigns, :webmaster_id)
    add_index :campaigns, :enabled unless (index_exists? :campaigns, :enabled)
    add_index :campaigns, :is_default unless (index_exists? :campaigns, :is_default)
    add_index :campaigns, :relative_id unless (index_exists? :campaigns, :relative_id)
  end
end
