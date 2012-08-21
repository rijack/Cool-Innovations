class AddStationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :station_id, :integer
  end
end
