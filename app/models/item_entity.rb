class ItemEntity < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__item_entity__c'

  belongs_to :bom, primary_key: 'sfid', foreign_key: 'i_m__to_bom__c'
  belongs_to :item, primary_key: 'sfid', foreign_key: 'i_m__to_item__c'
  
  validates_presence_of :sfid, :name, :i_m__amount__c, :bom, :item 
end
