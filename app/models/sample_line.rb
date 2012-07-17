class SampleLine < ActiveRecord::Base
  attr_accessible :comment_id, :part_id, :quantity, :new_part_number

  validates_presence_of  :quantity

  belongs_to :comment
  belongs_to :part
end
