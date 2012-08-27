class Station < ActiveRecord::Base
  attr_accessible :location, :name, :notes, :priority

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :users

end
