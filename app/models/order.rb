class Order < ActiveRecord::Base
  self.table_name = 'salesforce.order'

  belongs_to :account, primary_key: "sfid", foreign_key: "accountid"
  belongs_to :opportunity, primary_key: "sfid", foreign_key: "i_m__related_opportunity__c"

  validates_presence_of :name, :sfid
end