class UpdateUserProcessDefaultValue < ActiveRecord::Migration
  def change
    change_column_default(:order_line_process_statuses, :user_priority, 99)
  end
end
