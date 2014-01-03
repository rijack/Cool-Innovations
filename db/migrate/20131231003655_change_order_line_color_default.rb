class ChangeOrderLineColorDefault < ActiveRecord::Migration
  def change
    change_column_default(:order_lines, :color, "f-white")
  end
end
