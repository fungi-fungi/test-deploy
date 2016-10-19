class Api::V1::RequestEntitySerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name, :amount, :createddate
  
  belongs_to :item, serializer: Api::V1::ItemSerializer
  
  def amount
    object.i_m__amount__c
  end
end