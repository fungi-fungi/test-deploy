class Category < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__category__c'
  
  has_many :items, primary_key: "i_m__externalid__c", foreign_key: "i_m__category__c__i_m__externalid__c"
  has_many :category_entities, primary_key: 'sfid', foreign_key: 'i_m__to_category__c'

  validates :sfid, :name, :i_m__externalid__c, presence: true
end
