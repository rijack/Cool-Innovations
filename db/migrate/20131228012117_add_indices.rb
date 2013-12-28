class AddIndices < ActiveRecord::Migration
  def change
    add_index :required_hardwares, [:part_id, :hardware_id] 
    add_index :order_lines, [:part_id, :status]
  end
end
