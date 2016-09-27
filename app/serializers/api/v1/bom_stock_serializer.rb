class Api::V1::BomStockSerializer < ActiveModel::Serializer
  attribute :id

  belongs_to :bom, serializer: Api::V1::BomSimpleSerializer
  has_many :entities, serializer: Api::V1::BomStockEntitySerializer
  
  def entities
    object.bom_stock_entities
  end

end