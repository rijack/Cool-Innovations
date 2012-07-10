class AddShippingMethodToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :shipping_method_id, :integer
  end
end
