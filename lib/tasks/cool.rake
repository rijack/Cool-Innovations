namespace :cool do
  desc "Move order attachment to attachments model"
  task :move_attachments => :environment do
    Order.where("attachment_file_name IS NOT NULL").each do |order|
      attachment = order.attachments.build
      attachment.file_file_name = order.attachment_file_name
      attachment.file_file_size = order.attachment_file_size
      attachment.file_content_type = order.attachment_content_type
      attachment.file_updated_at = order.attachment_updated_at
      order.save

      FileUtils.mkdir_p File.dirname(attachment.file.path)
      FileUtils.cp order.attachment.path, attachment.file.path
    end
  end
end
