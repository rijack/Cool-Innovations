class Hardware < ActiveRecord::Base
  attr_accessible :description, :name

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :parts, :through => :required_hardwares
end
