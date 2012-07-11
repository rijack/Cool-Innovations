class AddFieldsToHardwares < ActiveRecord::Migration
  def change
    add_column :hardwares, :vendor_name, :text
    add_column :hardwares, :pricing_i, :text
    add_column :hardwares, :pricing_history, :text
  end
end
