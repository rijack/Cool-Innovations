class RequiredProcess < ActiveRecord::Base
  attr_accessible :part_id, :part_process_id

  validates_presence_of :part_id, :part_process_id
  validates_uniqueness_of :part_process_id, :scope => :part_id

  belongs_to :part_process
  belongs_to :part

  after_create  :build_statuses
  after_destroy :remove_statuses

  private

  def build_statuses
    self.part.order_lines.not_shipped.each do |order_line|
      status = order_line.order_line_process_statuses.new(
          :status => "pending"
      )
      status.part_process_id = self.part_process_id
      status.save
    end
  end

  def remove_statuses
    self.part.order_lines.not_shipped.each do |order_line|
      order_line.order_line_process_statuses.where(:part_process_id => self.part_process_id).destroy_all
    end
  end
end
