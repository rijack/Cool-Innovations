class AddActualShipDateToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :actual_ship_date, :date
  end
end
