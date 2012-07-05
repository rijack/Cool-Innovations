class AddAttachmentAttachmentToOrders < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.has_attached_file :attachment
    end
  end

  def self.down
    drop_attached_file :orders, :attachment
  end
end
