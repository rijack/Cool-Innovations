class HardwareCategory < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :hardwares
end
