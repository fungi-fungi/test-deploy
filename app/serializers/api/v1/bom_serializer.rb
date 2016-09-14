class Api::V1::BomSerializer < ActiveModel::Serializer
  attributes :id, :sfid
  
  has_many :item_entities, serializer: Api::V1::ItemEntitySerializer
end