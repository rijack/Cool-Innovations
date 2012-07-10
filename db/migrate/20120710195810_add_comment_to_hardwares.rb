class AddCommentToHardwares < ActiveRecord::Migration
  def change
    add_column :hardwares, :comment, :text
  end
end
