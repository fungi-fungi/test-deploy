class Account < ActiveRecord::Base
  self.table_name = 'salesforce.account'
  has_many :stock_items, primary_key: "sfid", foreign_key: "i_m__to_account__c"

  validates :name, :sfid, presence: true
end