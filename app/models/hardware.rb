class Hardware < ActiveRecord::Base
  attr_accessible :description, :name, :vendor_name, :pricing_i, :pricing_history, :hardware_category_id, :attachment

  validates_presence_of :name, :hardware_category_id
  validates_uniqueness_of :name, :case_sensitive => false, :scope => :hardware_category_id



  belongs_to :hardware_category
  has_many :required_hardwares
  has_many :parts, :through => :required_hardwares
  has_many :order_lines, :through => :parts

  has_attached_file :attachment

  def required_count(options = {})
    count = 0
    lines = options[:shipped] ? order_lines.shipped : order_lines.not_shipped
    hardware_quantity = {}
    lines.each do |order_line|

      hardware_quantity[order_line.part.id] ||= (order_line.part.required_hardwares.where{hardware_id == my{id}}.first.try(:quantity) || 0)
      count += (order_line.quantity || 0) * hardware_quantity[order_line.part.id]
    end

    count
  end

  def self.order_by_priority
    includes(:hardware_category)
    .order("hardware_categories.sort_priority")
  end
end
