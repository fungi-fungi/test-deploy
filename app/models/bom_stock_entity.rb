class BomStockEntity < ActiveModelSerializers::Model
  attr_accessor :id, :item_entity, :avaliable_amount
end