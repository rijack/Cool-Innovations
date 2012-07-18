class PartProcess < ActiveRecord::Base
  attr_accessible :description, :name, :part_process_category_id

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  belongs_to :part_process_category
  has_many :required_processes, :dependent => :destroy
  has_many :parts, :through => :required_processes

  has_many :order_line_process_statuses
  has_many :order_lines, :through => :order_line_process_statuses

  def order_lines_with_pending
    order_lines.pending.where{(order_line_process_statuses.status == "in progress") | (order_line_process_statuses.status == "pending")}.order("order_line_process_statuses.order_line_priority asc")
  end
end
