class AvaliableStock
  include ActiveModel::Model

  attr_accessor :item, :amount

  validates_presence_of :item, :amount
end