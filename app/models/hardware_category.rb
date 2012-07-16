class HardwareCategory < ActiveRecord::Base
  attr_accessible :name

  has_many :hardwares, :dependent => :destroy
end
