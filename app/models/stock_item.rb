class StockItem < ActiveRecord::Base
    self.table_name = 'salesforce.i_m__stock_item__c'
    
    belongs_to :account, primary_key: "sfid", foreign_key: "i_m__to_account__c"
    belongs_to :item, primary_key: "sfid", foreign_key: "i_m__to_item__c"

    validates_presence_of :name, :sfid, :account, :item, :i_m__amount__c, :i_m__location__c, :createddate
end