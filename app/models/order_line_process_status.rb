class OrderLineProcessStatus < ActiveRecord::Base
  belongs_to :order_line
  belongs_to :part_process

  attr_accessible :status

  after_save :set_order_line_status, :if => :status_changed?

  after_destroy :set_order_line_status

  validate :check_order

  protected
  def check_order
    if order_line.status == "shipped"
      errors.add :status, "Order has already been shipped."
    end
  end

  private

  def set_order_line_status
    statuses = self.order_line.order_line_process_statuses.collect &:status

    if statuses.all? {|x| x == "completed" }
      self.order_line.status = "completed"
    elsif statuses.all? {|x| x == "assigned" }
      self.order_line.status = "assigned"
    elsif statuses.any? {|x| x == "in progress" }
      self.order_line.status = "in progress"
    elsif statuses.any? {|x| x == "completed" }
      self.order_line.status = "in progress"
    else
      self.order_line.status = "pending"
    end

    self.order_line.save
  end
end
