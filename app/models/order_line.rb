class OrderLine < ActiveRecord::Base
  STATUSES = [
    "pending",
    "in progress",
    "completed"
  ]

  COLORS = [
      "white",
      "green",
      "red"
  ]

  attr_accessible :due_date, :ship_date, :order_id, :part_id, :quantity, :comment, :production_comment, :price, :shipping_method_id, :line_number, :tracking_number, :_destroy

  validates_presence_of :due_date, :part_id, :quantity

  belongs_to :order
  belongs_to :part
  belongs_to :shipping_method

  has_many :order_line_process_statuses, :dependent => :destroy

  after_create :build_statuses

  after_destroy :check_order

  def self.shipped
    where { status == "shipped" }
  end

  def self.not_shipped
    where { status != "shipped" }
  end

  def self.pending
    where { status != "completed" && status != "shipped" }
  end

  # shipped => true | false
  # client_id => 
  # order_id => 
  # params => 
  # sort =>
  # page =>
  # per_page =>
  def self.search(options = {})
    order_lines = OrderLine.joins(:order => :client).joins(:part)
    order_lines = options[:shipped] ? order_lines.shipped : order_lines.not_shipped
    order_lines = order_lines.where{clients.id == options[:client_id]} if options[:client_id].present?
    order_lines = order_lines.where{orders.id == options[:order_id]} if options[:order_id].present?
    order_lines = order_lines.where(options[:search]) if options[:search].present?

    order_lines = order_lines.order(options[:sort]).page(options[:page] || 1).per_page(options[:per_page] || 10)
  end

  private

  def build_statuses
    self.part.part_processes.each do |process|
      status = self.order_line_process_statuses.new(
        :status => "pending"
      )
      status.part_process_id = process.id
      status.save
    end
  end

  # check if order should be deleted
  def check_order
    if order.order_lines.count == 0
      order.destroy
    end
  end
end
