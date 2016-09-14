class Api::V1::CategoryEntitySerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name , :createddate
  
  belongs_to :category
  
end