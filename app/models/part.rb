class Part < ActiveRecord::Base
  attr_accessible :description, :drawing_number, :name, :part_number

  validates_presence_of :part_number, :drawing_number
  validates_uniqueness_of :part_number, :case_sensitive => false
  validates_uniqueness_of :drawing_number, :case_sensitive => false

  has_many :hardwares, :through => :required_hardwares
end
