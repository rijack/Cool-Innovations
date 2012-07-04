class Client < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :orders, :dependent => :destroy
  has_many :order_lines, :through => :orders
end
