class SuggestedRentalEntity < ActiveRecord::Base
    self.table_name = 'salesforce.i_m__suggested_rental_entity__c'

    belongs_to :suggested_rental_set, primary_key: 'sfid', foreign_key: 'i_m__to_suggested_rental_set__c'
    belongs_to :item, primary_key: 'sfid', foreign_key: 'i_m__to_item__c'

    validates_presence_of :sfid, :name, :suggested_rental_set, :item 
end