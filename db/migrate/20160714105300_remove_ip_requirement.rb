class RemoveIpRequirement < ActiveRecord::Migration
  def change
    change_column :customers, :ip, :string, null: true
  end
end
