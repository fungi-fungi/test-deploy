class Api::V1::ItemEntitySerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name, :amount, :createddate
  
  # belongs_to :bom
  belongs_to :item
  
  def amount 
    object.i_m__amount__c
  end
end