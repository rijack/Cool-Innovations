class SampleLine < ActiveRecord::Base
  attr_accessible :comment_id, :part_id, :quantity

  validates_presence_of  :part_id, :quantity

  belongs_to :comment
  belongs_to :part
end
