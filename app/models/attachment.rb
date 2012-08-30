class Attachment < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :file, :show_on_floor

  has_attached_file :file
  validates_attachment_presence :file

  belongs_to :attachable, :polymorphic => true

  def url(*args)
    "/attachments/#{self.id}"
  end

  def name
    file_file_name
  end 

  def content_type
    file_content_type
  end 

  def size
    file_file_size
  end 
end
