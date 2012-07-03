class AddStatusToOrderLine < ActiveRecord::Migration
  def change
    add_column :order_lines, :status, :string, :default => "pending"
  end
end
