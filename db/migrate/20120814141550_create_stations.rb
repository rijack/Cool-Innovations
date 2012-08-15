class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :location
      t.text :notes

      t.timestamps
    end
  end
end
