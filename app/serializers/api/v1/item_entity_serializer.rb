class Api::V1::ItemEntitySerializer < ActiveModel::Serializer
  attributes :id, :sfid, :item, :amount, :createddate

  belongs_to :item, serializer: Api::V1::ItemSerializer
  
  def amount 
    object.i_m__amount__c
  end

end