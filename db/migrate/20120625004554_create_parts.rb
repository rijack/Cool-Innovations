class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name
      t.text :description
      t.string :part_number
      t.string :drawing_number

      t.timestamps
    end
  end
end
