class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :username, :status, :name, :avatar, :station_id, :station_priority, :station_display
  attr_accessor :editor

  validates_presence_of :email, :username
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email, :username, :case_sensitive => false
  validate :validate_user_type

  belongs_to :station
  has_many :comments
  has_many :order_line_process_statuses

  has_attached_file :avatar, :styles => { :large => "300x300", :medium => "100x100>", :thumb => "50x50>",  }
  #has_attached_file :avatar

  def self.users_only
    where{ status == "user" }
      .order("name asc")
  end

  def not_completed_processes
    self.order_line_process_statuses
      .joins(:order_line)
      .where {(order_line_process_statuses.status != "verified")}
      .where{order_lines.status != "shipped" }
      .order('user_priority asc')
  end

  def admin?
    status == "admin"
  end

  def manager?
    status == "manager"
  end

  def manager_or_admin?
    admin? || manager?
  end

  def not_user?
    status != "user"
  end

  def allowed_session_length
    if status == "station"
      24.hours.ago
    else
      30.minutes.ago
    end
  end

  def layout
    if status == "station"
      "station"
    else
      "application"
    end
  end

  def allowed_user_types
    types = [
      "manager",
      "manager training",
      "asst manager",
      "user",
      "station"
    ]

    types.unshift "admin" if self.admin?

    types
  end

  def validate_user_type
    if !editor || !editor.allowed_user_types.include?(status)
      errors.add(:status, "you cannot update to this status")
    end
  end
end
