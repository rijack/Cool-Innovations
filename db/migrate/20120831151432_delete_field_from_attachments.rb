class DeleteFieldFromAttachments < ActiveRecord::Migration
  def change
    remove_column :attachments, :show_on_floor
  end
end