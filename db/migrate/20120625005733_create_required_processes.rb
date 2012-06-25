class CreateRequiredProcesses < ActiveRecord::Migration
  def change
    create_table :required_processes do |t|
      t.integer :part_id
      t.integer :part_process_id

      t.timestamps
    end
  end
end
