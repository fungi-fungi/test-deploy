class Api::V1::RequestBomSerializer < ActiveModel::Serializer
  attributes :id

  has_many :request_entities, serializer: Api::V1::RequestEntitySerializer

end