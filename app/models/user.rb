class User < ActiveRecord::Base
  has_secure_password

  USER_TYPES = [
      "admin",
      "manager",
      "user"
  ]

  attr_accessible :email, :password, :username, :status, :name, :avatar, :station_id

  validates_presence_of :email, :username
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email, :username, :case_sensitive => false

  belongs_to :station
  has_many :comments
  has_many :order_line_process_statuses

  has_attached_file :avatar, :styles => { :large => "300x300", :medium => "100x100>", :thumb => "50x50>",  }
  #has_attached_file :avatar

  def self.users_only
    where { status == "user" }
    .order ("name asc")
  end

  def admin?
    status == "admin"
  end
end
