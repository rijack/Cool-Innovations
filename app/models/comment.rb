class Comment < ActiveRecord::Base
  belongs_to :user
  attr_accessible :message
end
