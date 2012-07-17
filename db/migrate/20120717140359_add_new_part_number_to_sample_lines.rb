class AddNewPartNumberToSampleLines < ActiveRecord::Migration
  def change
    add_column :sample_lines, :new_part_number, :string
  end
end
