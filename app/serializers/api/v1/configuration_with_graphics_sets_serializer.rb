class Api::V1::ConfigurationWithGraphicsSetsSerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name

  has_many :graphics_sets, serializer: Api::V1::GraphicsSetSerializer
end