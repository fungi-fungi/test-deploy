class RequestBom < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__request_bom__c'
  # self.primary_key = 'i_m__externalid__c'

  has_many :items, through: :request_entities
  has_many :request_entities, primary_key: "i_m__externalid__c", foreign_key: "i_m__to_request_bom__r__i_m__externalid__c", inverse_of: :request_bom
  has_one :order_request, primary_key: "i_m__externalid__c", foreign_key: "i_m__to_request_bom__r__i_m__externalid__c"
  accepts_nested_attributes_for :request_entities

  # before_validation :set_id
  
  def initialize(attributes={})
    super
    write_attribute(:i_m__externalid__c, SecureRandom.hex(5)) unless self.i_m__externalid__c
  end

  # private

  # def set_id
  #   self.i_m__externalid__c = SecureRandom.hex(5)
  # end
  
end
