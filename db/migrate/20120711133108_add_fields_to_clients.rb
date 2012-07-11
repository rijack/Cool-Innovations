class AddFieldsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :payment_instructions, :text
    add_column :clients, :shipping_instructions, :text
    add_column :clients, :special_instructions, :text
  end
end
