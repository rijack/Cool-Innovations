class Comment < ActiveRecord::Base
  attr_accessible :message, :sample_lines_attributes, :customer_name, :contact_name, :address, :shipping_account_info, :comment
  belongs_to :user


  has_many :sample_lines, :dependent => :destroy
  has_many :parts, :through => :sample_lines

  accepts_nested_attributes_for :sample_lines

end

