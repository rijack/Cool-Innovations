class CreateRequiredHardwares < ActiveRecord::Migration
  def change
    create_table :required_hardwares do |t|
      t.integer :part_id
      t.integer :hardware_id
      t.integer :quantity

      t.timestamps
    end
  end
end
