class AddOrderLinePriorityToOrderLineProcessStatuses < ActiveRecord::Migration
  def change
    add_column :order_line_process_statuses, :order_line_priority, :integer, :default => 10000
  end
end
