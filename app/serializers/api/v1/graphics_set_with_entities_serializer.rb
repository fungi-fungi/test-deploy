class Api::V1::GraphicsSetWithEntitiesSerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name
  
  has_many :graphic_entities, serializer: Api::V1::GraphicEntitySerializer
end