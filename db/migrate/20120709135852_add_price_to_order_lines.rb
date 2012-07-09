class AddPriceToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :price, :decimal, :precision => 8, :scale => 2
  end
end
