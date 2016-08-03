class Api::V1::ConfigurationDetailsSerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name, :created_at
  has_one :bom
  has_one :category_set

  def created_at
    object.createddate.in_time_zone.iso8601 if object.createddate
  end

end