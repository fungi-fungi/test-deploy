class Api::V1::CategoryEntitySerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name , :createddate
  belongs_to :category
  belongs_to :category_set
  
end