class Api::V1::BomSimpleSerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name
end