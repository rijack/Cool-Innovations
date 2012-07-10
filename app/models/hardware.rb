class Hardware < ActiveRecord::Base
  attr_accessible :description, :name

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :required_hardwares
  has_many :parts, :through => :required_hardwares
  has_many :order_lines, :through => :parts

  def required_count(options = {})
    count = 0
    lines = options[:shipped] ? order_lines.shipped : order_lines.not_shipped
    lines.each do |order_line|
      count += (order_line.quantity || 0) * (order_line.part.required_hardwares.where{hardware_id == self.id}.first.try(:quantity) || 0)
    end

    count
  end

end
