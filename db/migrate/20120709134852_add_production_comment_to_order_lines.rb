class AddProductionCommentToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :production_comment, :text
  end
end
