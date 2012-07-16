class AddPartProcessCategoryToPartProcess < ActiveRecord::Migration
  def change
    add_column :part_processes, :part_process_category_id, :integer
  end
end
