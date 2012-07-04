class Order < ActiveRecord::Base
  attr_accessible :client_id, :purchase_order, :order_lines_attributes

  validates_presence_of :client_id, :purchase_order
  validates_uniqueness_of :purchase_order, :case_sensitive => false

  belongs_to :client
  has_many :order_lines, :dependent => :destroy
  has_many :parts, :through => :order_lines

  accepts_nested_attributes_for :order_lines
end
