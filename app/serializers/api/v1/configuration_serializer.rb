class Api::V1::ConfigurationSerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name, :created_at

  def created_at
    object.createddate.in_time_zone.iso8601 if object.createddate
  end
end