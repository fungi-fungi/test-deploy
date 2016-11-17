class Api::V1::AvailableItemEntitySerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name, :category, :amount_in_stock, :amount_reserved, :amount_avaliable

  def category
    object.category.name
  end

  def amount_in_stock
    object.total_in_stock
  end

  def amount_reserved
    object.total_reserved
  end

  def amount_avaliable
    object.total_avaliable
  end

end
