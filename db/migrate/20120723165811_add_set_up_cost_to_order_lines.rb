class AddSetUpCostToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :setup_cost, :integer
  end
end
