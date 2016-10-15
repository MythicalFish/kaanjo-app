class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.references :webmaster
      t.string :title
      t.text :description
      t.string :site_path
      t.boolean :status
      t.date :start_date
      t.date :end_date
      t.string :question
      t.integer :sid, null: false
      t.timestamps
    end
    add_index :campaigns, :created_at
    add_index :campaigns, :webmaster_id
    add_index :campaigns, :status
    add_index :campaigns, :sid
  end
end
