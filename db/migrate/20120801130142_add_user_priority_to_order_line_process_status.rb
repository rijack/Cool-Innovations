class AddUserPriorityToOrderLineProcessStatus < ActiveRecord::Migration
  def change
    add_column :order_line_process_statuses, :user_priority, :integer, :default => 10000
  end
end
