class Bom < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__bom__c'

  validates :name, :sfid, presence: true
end