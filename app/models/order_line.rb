class OrderLine < ActiveRecord::Base
  attr_accessible :due_date, :order_id, :part_id, :quantity, :comment

  validates_presence_of :due_date, :order_id, :part_id, :quantity

  belongs_to :order
  belongs_to :part
end
