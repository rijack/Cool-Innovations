class RequiredHardware < ActiveRecord::Base
  attr_accessible :hardware_id, :part_id, :quantity

  validates_presence_of :hardware_id, :part_id, :quantity
  validates_uniqueness_of :hardware_id, :scope => :part_id

  has_many :required_hardwares
  has_many :parts, :through => :required_hardwares
end
