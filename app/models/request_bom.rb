class RequestBom < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__request_bom__c'
  self.primary_key = 'i_m__externalid__c'

  has_many :items, through: :request_entities
  has_many :request_entities, primary_key: "i_m__externalid__c", foreign_key: "i_m__to_request_bom__r__i_m__externalid__c"
  has_one :order_request, primary_key: "i_m__externalid__c", foreign_key: "i_m__to_request_bom__r__i_m__externalid__c"

  validates_presence_of :name, :i_m__externalid__c
  
  before_validation :set_id

  private

  def set_id
    self.i_m__externalid__c = SecureRandom.hex(5)
  end
  
end
