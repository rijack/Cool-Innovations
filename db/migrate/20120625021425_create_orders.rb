class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :purchase_order
      t.integer :client_id

      t.timestamps
    end
  end
end
