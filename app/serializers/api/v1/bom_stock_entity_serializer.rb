class Api::V1::BomStockEntitySerializer < ActiveModel::Serializer
  attributes :item_sfid, :item_name, :required_amount, :avaliable_amount

  def required_amount
    object.item_entity.i_m__amount__c
  end

  def item_name
    object.item_entity.item.name
  end

  def item_sfid
    object.item_entity.i_m__to_item__c
  end

end