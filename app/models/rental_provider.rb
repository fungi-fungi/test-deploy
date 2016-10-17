class RentalProvider < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__rental_provider__c'

  belongs_to :account, primary_key: "sfid", foreign_key: "i_m__account__c"

  validates_associated :account
  validates_presence_of :account, :name, :sfid
  
end