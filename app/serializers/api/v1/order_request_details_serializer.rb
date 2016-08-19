class Api::V1::OrderRequestDetailsSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :event
  belongs_to :request_bom

end