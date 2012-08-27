class AddPriorityToStations < ActiveRecord::Migration
  def change
    add_column :stations, :priority, :integer, :default => 99
  end
end
