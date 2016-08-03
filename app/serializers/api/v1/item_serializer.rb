class Api::V1::ItemSerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name
end