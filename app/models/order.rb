class Order < ActiveRecord::Base
  attr_accessible :client_id, :purchase_order

  belongs_to :client

  validates_presence_of :client_id, :purchase_order
  validates_uniqueness_of :purchase_order
end
