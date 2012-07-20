class HardwareCategory < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :hardwares

  before_destroy :check_for_first
  after_destroy :assign_to_default

  def check_for_first
    if id == 1 || name == "default"
      errors.add(:base, "Cannot delete default category")
      return false
    end
  end

  def assign_to_default
    category_id = self.class.find_by_name("default").try(:id) || 1
    hardwares.update_all(:hardware_category_id => category_id)
  end

  def hardwares_ordered_by_priority
    hardwares.order_by_priority
  end
end
