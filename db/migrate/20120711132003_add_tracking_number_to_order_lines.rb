class AddTrackingNumberToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :tracking_number, :string
  end
end
