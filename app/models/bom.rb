class Bom < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__bom__c'
  
  has_many :items, through: :item_entities
  has_many :item_entities, primary_key: "sfid", foreign_key: "i_m__to_bom__c"
  has_one :configuration, primary_key: "sfid", foreign_key: "i_m__to_bom__c"

  validates_presence_of :name, :sfid
end