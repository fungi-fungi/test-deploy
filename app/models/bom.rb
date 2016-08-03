class Bom < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__bom__c'
  has_many :item_entities, primary_key: "sfid", foreign_key: "i_m__to_bom__c"


  validates :name, :sfid, presence: true
end