class RemoveProductionCommentFromOrderLine < ActiveRecord::Migration
  def up
    remove_column :order_lines, :production_comment
  end

  def down
    add_column :order_lines, :production_comment, :string
  end
end
