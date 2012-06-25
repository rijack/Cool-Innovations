class CreatePartProcesses < ActiveRecord::Migration
  def change
    create_table :part_processes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
