class Api::V1::SuggestedRentalEntitySerializer < ActiveModel::Serializer
  attributes :id, :sfid

  has_one :item, serializer: Api::V1::ItemDetailsSerializer
end