class Configuration < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__configuration__c'

  belongs_to :account, primary_key: "sfid", foreign_key: "i_m__to_account__c"
  has_one :bom, primary_key: "i_m__to_bom__c", foreign_key: "sfid"
  has_one :category_set, primary_key: "i_m__to_category_set__c", foreign_key: "sfid"

  validates :name, :sfid, :account, :bom, :category_set, presence: true
end