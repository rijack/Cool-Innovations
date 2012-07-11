class AddLineNumbersToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :line_number, :integer
  end
end
