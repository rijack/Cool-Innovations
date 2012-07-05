class AddShipDateToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :ship_date, :date
  end
end
