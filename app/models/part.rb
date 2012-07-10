class Part < ActiveRecord::Base
  attr_accessible :description, :drawing_number, :name, :part_number, :part_process_ids, :required_hardwares_attributes, :attachment

  validates_presence_of :part_number, :drawing_number
  validates_uniqueness_of :part_number, :case_sensitive => false
  validates_uniqueness_of :drawing_number, :case_sensitive => false

  has_many :required_hardwares
  has_many :required_processes
  has_many :hardwares, :through => :required_hardwares, :class_name => "Hardware"
  has_many :part_processes, :through => :required_processes, :class_name => "PartProcess"
  has_many :order_lines

  accepts_nested_attributes_for :required_hardwares
  accepts_nested_attributes_for :required_processes
  has_attached_file :attachment

  def name
    part_number
  end
end
