class Part < ActiveRecord::Base
  attr_accessible :description, :drawing_number, :name, :part_number

  validates_presence_of :part_number, :drawing_number
  validates_uniqueness_of :part_number, :case_sensitive => false
  validates_uniqueness_of :drawing_number, :case_sensitive => false

  has_many :required_hardwares
  has_many :required_processes
  has_many :hardwares, :through => :required_hardwares, :class_name => "Hardware"
  has_many :part_processes, :through => :required_processes
end
