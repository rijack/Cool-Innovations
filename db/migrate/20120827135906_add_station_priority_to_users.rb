class AddStationPriorityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :station_priority, :integer, :default => 99
  end
end
