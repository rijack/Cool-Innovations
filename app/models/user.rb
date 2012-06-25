class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :username

  validates_presence_of :email, :username
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email, :username, :case_sensitive => false
end
