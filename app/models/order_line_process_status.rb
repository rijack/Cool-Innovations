class OrderLineProcessStatus < ActiveRecord::Base
  belongs_to :order_line
  belongs_to :part_process

  attr_accessible :status

  after_save :set_order_line_status, :if => :status_changed?

  private

  def set_order_line_status
    statuses = self.order_line.order_line_process_statuses.collect &:status

    if statuses.all? {|x| x == "completed" }
      self.order_line.status = "completed"
    else
      self.order_line.status = "pending"
    end

    self.order_line.save
  end
end
