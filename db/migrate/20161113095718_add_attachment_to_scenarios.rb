class AddAttachmentToScenarios < ActiveRecord::Migration
  def change
    add_attachment :scenarios, :custom_emoticon
    add_column :scenarios, :sid, :string, null: false
    add_index :scenarios, :sid
  end
end
