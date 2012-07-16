class CreatePartProcessCategories < ActiveRecord::Migration
  def change
    create_table :part_process_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
