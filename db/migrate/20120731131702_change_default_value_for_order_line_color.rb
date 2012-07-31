class ChangeDefaultValueForOrderLineColor < ActiveRecord::Migration
  def change
    change_column_default(:order_lines, :color, "d-white")
  end
end
