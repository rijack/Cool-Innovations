class AddStationDisplayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :station_display, :string, :default => "true"
  end
end
