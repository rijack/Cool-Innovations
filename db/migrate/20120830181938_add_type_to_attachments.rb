class AddTypeToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :show_on_floor, :string, :default => "true"
  end
end
