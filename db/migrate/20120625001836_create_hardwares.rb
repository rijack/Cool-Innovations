class CreateHardwares < ActiveRecord::Migration
  def change
    create_table :hardwares do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
