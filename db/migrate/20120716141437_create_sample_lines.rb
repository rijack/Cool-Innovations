class CreateSampleLines < ActiveRecord::Migration
  def change
    create_table :sample_lines do |t|
      t.integer :comment_id
      t.integer :part_id
      t.integer :quantity

      t.timestamps
    end
  end
end
