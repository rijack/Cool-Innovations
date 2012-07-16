class AddSampleLineToComments < ActiveRecord::Migration
  def change
    add_column :comments, :sample_line_id, :integer
  end
end
