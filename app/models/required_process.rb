class RequiredProcess < ActiveRecord::Base
  attr_accessible :part_id, :part_process_id

  validates_presence_of :part_id, :part_process_id
  validates_uniqueness_of :part_process_id, :scope => :part_id

  belongs_to :hardware
  belongs_to :part
end
