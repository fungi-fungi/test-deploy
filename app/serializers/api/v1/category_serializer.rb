class Api::V1::CategorySerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name
end