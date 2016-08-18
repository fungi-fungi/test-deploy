class RequestBom < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__request_bom__c'
  self.primary_key = 'i_m__externalid__c'

  validates_presence_of :name, :i_m__externalid__c
  
  after_initialize :init

  def init
    self.i_m__externalid__c = SecureRandom.hex(5)
  end
  
end