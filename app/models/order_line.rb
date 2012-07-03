class OrderLine < ActiveRecord::Base
  attr_accessible :due_date, :order_id, :part_id, :quantity, :comment, :_destroy

  validates_presence_of :due_date, :part_id, :quantity

  belongs_to :order
  belongs_to :part

  has_many :order_line_process_statuses

  after_create :build_statuses

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
end
