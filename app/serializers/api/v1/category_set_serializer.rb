class Api::V1::CategorySetSerializer < ActiveModel::Serializer
  attributes :id, :sfid
  has_many :category_entities
end