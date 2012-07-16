class AddFiedlsToComment < ActiveRecord::Migration
  def change
    add_column :comments, :customer_name, :string
    add_column :comments, :contact_name, :string
    add_column :comments, :address, :text
    add_column :comments, :shipping_account_info, :text
    add_column :comments, :comment, :text
  end
end
