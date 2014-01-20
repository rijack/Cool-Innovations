class AddBreakdownToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :breakdown, :text
  end
end
