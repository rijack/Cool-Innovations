class RequiredHardware < ActiveRecord::Base
  attr_accessible :hardware_id, :part_id, :quantity

  validates_presence_of :hardware_id, :part_id, :quantity
end
