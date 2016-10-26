class Account < ActiveRecord::Base
  self.table_name = 'salesforce.account'
  
  has_many :stock_items, primary_key: "sfid", foreign_key: "i_m__to_account__c"
  has_many :configurations, primary_key: "sfid", foreign_key: "i_m__to_account__c"
  has_many :order_requests, primary_key: "sfid", foreign_key: "i_m__to_account__c"
  has_many :events, primary_key: "sfid", foreign_key: "i_m__convention_center__c"
  belongs_to :suggested_rental_set, primary_key: "sfid", foreign_key: "i_m__to_suggested_renatal_set__c"

  validates_presence_of :name, :sfid
end