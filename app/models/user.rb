class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :username, :status, :name, :avatar

  validates_presence_of :email, :username
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email, :username, :case_sensitive => false

  has_many :comments

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  #has_attached_file :avatar

  def admin?
    status == "admin"
  end
end
