class PartProcess < ActiveRecord::Base
  attr_accessible :description, :name

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :required_processes
  has_many :parts, :through => :required_processes

  has_many :order_line_process_statuses
  has_many :order_lines, :through => :order_line_process_statuses

  def order_lines_with_pending
    order_lines.pending.where{(order_line_process_statuses.status == "in progress") | (order_line_process_statuses.status == "pending")}
  end
end
