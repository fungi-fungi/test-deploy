class Item < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__item__c'
  belongs_to :category, primary_key: "i_m__externalid__c", foreign_key: "i_m__category__c__i_m__externalid__c"

  validates :name, :category, :createddate, presence: true
end