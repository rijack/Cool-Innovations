class AddCommentToOrderLineProcessStatus < ActiveRecord::Migration
  def change
    add_column :order_line_process_statuses, :comment, :text
  end
end
