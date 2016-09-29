class Api::V1::ConfigurationDetailsSerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name, :img_path, :created_at
  
  belongs_to :bom, serializer: Api::V1::BomSerializer
  belongs_to :account
  belongs_to :category_set, serializer: Api::V1::CategorySetSerializer

  def created_at
    object.createddate.in_time_zone.iso8601 if object.createddate
  end

  def img_path
    SIGNER.presigned_url(:get_object, bucket: ENV['S3_BUCKET'], key: object.i_m__photo__c)
  end

end