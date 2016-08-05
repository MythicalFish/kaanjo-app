class AddThrottleAttributes < ActiveRecord::Migration
  def change

    add_column :users, :throttle_index_1, :integer, default: 0
    add_column :users, :throttle_timer_1, :datetime

    add_column :customers, :throttle_index_1, :integer, default: 0
    add_column :customers, :throttle_timer_1, :datetime

  end
end
