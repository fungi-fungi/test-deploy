class Api::V1::SuggestedREntalSerializer < ActiveModel::Serializer
  attributes :id, :sfid
  
  has_many :items, serializer: Api::V1::ItemDetailsSerializer
end