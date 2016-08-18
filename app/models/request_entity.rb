class RequestEntity < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__request_entity__c'

  belongs_to :item, primary_key: 'sfid', foreign_key: 'i_m__to_item__c'
  
  validates_presence_of :name, :i_m__amount__c, :item
  validates_numericality_of :i_m__amount__c, greater_than: 0

end