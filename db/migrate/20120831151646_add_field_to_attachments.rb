class AddFieldToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :hide_on_floor, :boolean, :default => 0
  end
end
