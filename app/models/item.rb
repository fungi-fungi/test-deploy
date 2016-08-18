class Item < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__item__c'
  
  has_many :item_entities, primary_key: 'sfid', foreign_key: 'i_m__to_item__c'
  has_many :request_entities, primary_key: 'sfid', foreign_key: 'i_m__to_item__c'
  has_many :stock_items, primary_key: "sfid", foreign_key: "i_m__to_item__c"
  belongs_to :category, primary_key: "i_m__externalid__c", foreign_key: "i_m__category__c__i_m__externalid__c"

  validates_presence_of :sfid, :name, :category, :createddate
end