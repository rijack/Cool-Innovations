class RemoveDrawingNumberFromParts < ActiveRecord::Migration
  def up
    remove_column :parts, :drawing_number
  end

  def down
    add_column :parts, :drawing_number, :string
  end
end
