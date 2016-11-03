class AlterScenarios < ActiveRecord::Migration
  def up
    remove_column :scenarios, :message_first
    change_column :scenarios, :message, :string, default: nil
    change_column :scenarios, :label, :string, null: true
  end
  def down
    add_column :scenarios, :message_first, :string
    change_column :scenarios, :label, :string, null: false
  end
end
