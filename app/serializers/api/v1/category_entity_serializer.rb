class Api::V1::CategoryEntitySerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name , :createddate
  has_one :category
  
end