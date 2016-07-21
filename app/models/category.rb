class Category < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__category__c'
  has_many :items, primary_key: "i_m__externalid__c", foreign_key: "i_m__category__c__i_m__externalid__c"

  validates :name, :i_m__externalid__c, presence: true
end
