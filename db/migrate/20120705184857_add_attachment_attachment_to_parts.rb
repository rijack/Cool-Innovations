class AddAttachmentAttachmentToParts < ActiveRecord::Migration
  def self.up
    change_table :parts do |t|
      t.has_attached_file :attachment
    end
  end

  def self.down
    drop_attached_file :parts, :attachment
  end
end
