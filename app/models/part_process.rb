class PartProcess < ActiveRecord::Base
  attr_accessible :description, :name, :part_process_category_id

  validates_presence_of :name, :part_process_category_id
  validates_uniqueness_of :name, :case_sensitive => false

  belongs_to :part_process_category
  #has_many :required_processes, :dependent => :destroy
  #has_many :parts, :through => :required_processes

  has_many :order_line_process_statuses
  has_many :order_lines, :through => :order_line_process_statuses

  def order_lines_with_pending
    order_lines.pending.where{(order_line_process_statuses.status == "in progress") | (order_line_process_statuses.status == "pending")| (order_line_process_statuses.status == "assigned")}.order("order_line_process_statuses.order_line_priority asc").order("due_date asc")
  end

  def order_lines_manual
    order_lines.any? do |order_line|
      order_line.order_line_process_statuses.where(:part_process_id => self.id).first.order_line_priority != 10000
    end
  end

  def self.order_by_priority
    includes(:part_process_category)
    .order("part_process_categories.sort_priority")
  end
end
