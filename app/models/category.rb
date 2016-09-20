class Category < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__category__c'
  
  has_many :items, primary_key: "sfid", foreign_key: "i_m__to_category__c"
  has_many :category_entities, primary_key: 'sfid', foreign_key: 'i_m__to_category__c'

  validates :sfid, :name, presence: true
end
