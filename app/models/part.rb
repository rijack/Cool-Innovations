class Part < ActiveRecord::Base
  attr_accessible :description, :name, :part_number, :part_process_ids, :required_hardwares_attributes, :attachment

  validates_presence_of :part_number
  validates_uniqueness_of :part_number, :case_sensitive => false

  has_many :required_hardwares
  has_many :required_processes
  has_many :hardwares, :through => :required_hardwares, :class_name => "Hardware"
  has_many :part_processes, :through => :required_processes, :class_name => "PartProcess", :after_remove => :handle_removed_processes
  has_many :order_lines
  has_many :sample_lines

  accepts_nested_attributes_for :required_hardwares
  has_attached_file :attachment

  after_save :handle_removed_processes

  def name
    part_number
  end

  def handle_removed_processes(value = nil)
    self.order_lines.not_shipped.each do |order_line|
      order_line.order_line_process_statuses.where{part_process_id == value.id}.destroy_all
    end if value
  end
end
