class RemoveNameFromParts < ActiveRecord::Migration
  def up
    remove_column :parts, :name
  end

  def down
    add_column :parts, :name, :string
  end
end
