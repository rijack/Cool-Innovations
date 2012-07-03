class CreateOrderLineProcessStatuses < ActiveRecord::Migration
  def change
    create_table :order_line_process_statuses do |t|
      t.references :order_line
      t.references :part_process
      t.string :status

      t.timestamps
    end
    add_index :order_line_process_statuses, :order_line_id
    add_index :order_line_process_statuses, :part_process_id
  end
end
