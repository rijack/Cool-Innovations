class AddHardwareCateoryToHardware < ActiveRecord::Migration
  def change
    add_column :hardwares, :hardware_category_id, :integer
  end
end
