class Api::V1::ItemDetailsSerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name, :category

  def category 
    object.category.name
  end
end