class AddPriorityToCategories < ActiveRecord::Migration
  def change
    add_column :part_process_categories, :sort_priority, :integer, :default => 10000
    add_column :hardware_categories, :sort_priority, :integer, :default => 10000
  end
end
