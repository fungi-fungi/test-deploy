class Api::V1::StockItemSerializer < ActiveModel::Serializer
  attributes :id, :sfid, :item, :name, :amount, :created_at

  def item
    object.item.sfid
  end

  def name
    object.item.name
  end

  def amount
  	object.i_m__amount__c
  end

  def created_at
    object.createddate.in_time_zone.iso8601 if object.createddate
  end
end
