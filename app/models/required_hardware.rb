class RequiredHardware < ActiveRecord::Base
  attr_accessible :hardware_id, :part_id, :quantity

  validates_presence_of :hardware_id, :quantity
  validates_uniqueness_of :hardware_id, :scope => :part_id

  belongs_to :hardware
  belongs_to :part
end
