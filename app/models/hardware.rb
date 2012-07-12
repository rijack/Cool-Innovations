class Hardware < ActiveRecord::Base
  attr_accessible :description, :name, :vendor_name, :pricing_i, :pricing_history

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :required_hardwares
  has_many :parts, :through => :required_hardwares
  has_many :order_lines, :through => :parts

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

end
