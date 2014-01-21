class Comment < ActiveRecord::Base
  attr_accessible :message, :sample_lines_attributes, :customer_name, :contact_name, :address, :shipping_account_info, :comment, :parent_id
  belongs_to :user


  has_many :sample_lines, :dependent => :destroy
  has_many :parts, :through => :sample_lines

  accepts_nested_attributes_for :sample_lines

  has_ancestry

  def self.homeOrders
    order_lines = OrderLine.joins(:order => :client).includes(:order => :client).includes(:part).joins(:part)
    order_lines = order_lines.where{(status != "shipped") & (color != "f-white") & (color != "white") & (color != "d-white")}
    order_lines = order_lines.order('color ASC, ship_date ASC, clients.name ASC')
  end
end

