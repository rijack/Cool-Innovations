class AddUserToOrderLineProcessStatus < ActiveRecord::Migration
  def change
    add_column :order_line_process_statuses, :user_id, :integer
  end
end
