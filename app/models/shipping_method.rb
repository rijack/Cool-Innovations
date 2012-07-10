class ShippingMethod < ActiveRecord::Base
  attr_accessible :duration, :name

  validates_presence_of :name, :duration
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :order_lines

end
