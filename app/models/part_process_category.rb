class PartProcessCategory < ActiveRecord::Base
  attr_accessible :name

  has_many :part_processes, :dependent => :destroy
end
