class AddProcessPriorityToRequiredProcess < ActiveRecord::Migration
  def change
    add_column :required_processes, :required_process_priority, :integer, :default => 10000
  end
end
