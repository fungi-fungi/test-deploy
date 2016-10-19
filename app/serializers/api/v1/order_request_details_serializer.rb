class Api::V1::OrderRequestDetailsSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :event, serializer: Api::V1::EventSerializer
  belongs_to :request_bom, serializer: Api::V1::RequestBomSerializer

end