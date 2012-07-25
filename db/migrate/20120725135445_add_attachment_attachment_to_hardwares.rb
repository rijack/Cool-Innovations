class AddAttachmentAttachmentToHardwares < ActiveRecord::Migration
  def self.up
    change_table :hardwares do |t|
      t.has_attached_file :attachment
    end
  end

  def self.down
    drop_attached_file :hardwares, :attachment
  end
end
