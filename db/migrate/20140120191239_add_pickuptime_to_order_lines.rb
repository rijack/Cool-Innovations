class AddPickuptimeToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :pickuptime, :string
  end
end
