class SuggestedRentalSet < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__suggested_rental_set__c'

  has_many :items, through: :suggested_rental_entities
  has_many :suggested_rental_entities, primary_key: "sfid", foreign_key: "i_m__to_suggested_rental_set__c"

  validates_presence_of :name, :sfid
end