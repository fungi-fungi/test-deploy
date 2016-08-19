class Api::V1::OrderRequestSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :event

end