class AvailableItemEntity < ActiveModelSerializers::Model

  attr_accessor :id, :sfid, :name, :category, :stock_items, :request_entities
  
  def total_in_stock
    stock_items.inject(0) { |sum, el|  sum += el.i_m__amount__c }
  end

  def total_reserved
    request_entities.inject(0) { |sum, el|  sum += el.i_m__amount__c }
  end

  def total_avaliable
    self.total_in_stock > self.total_reserved ? self.total_in_stock - self.total_reserved : 0 
  end

end