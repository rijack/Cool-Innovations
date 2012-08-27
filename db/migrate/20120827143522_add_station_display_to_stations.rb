class AddStationDisplayToStations < ActiveRecord::Migration
  def change
    add_column :stations, :station_display, :string, :default => "true"
  end
end
