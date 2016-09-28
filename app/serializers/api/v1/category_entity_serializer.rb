class Api::V1::CategoryEntitySerializer < ActiveModel::Serializer
  
  attributes :id, :sfid, :createddate
  
  belongs_to :category, serializer: Api::V1::CategorySerializer

end