class CreateHardwareCategories < ActiveRecord::Migration
  def change
    create_table :hardware_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
