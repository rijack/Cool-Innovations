class ChangeColumnScaleInOrderLines < ActiveRecord::Migration
  def change
    change_column(:order_lines, :price, :decimal, :precision => 8, :scale => 4)
  end
end
