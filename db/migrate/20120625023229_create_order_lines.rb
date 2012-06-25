class CreateOrderLines < ActiveRecord::Migration
  def change
    create_table :order_lines do |t|
      t.integer :order_id
      t.integer :part_id
      t.date :due_date
      t.integer :quantity
      t.text :comment

      t.timestamps
    end
  end
end
