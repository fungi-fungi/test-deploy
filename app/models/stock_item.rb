class StockItem < ActiveRecord::Base
    self.table_name = 'salesforce.i_m__stock_item__c'
    
    belongs_to :account, primary_key: "sfid", foreign_key: "i_m__to_account__c"
    belongs_to :item, primary_key: "sfid", foreign_key: "i_m__to_item__c"
    belongs_to :storage_location, primary_key: "sfid", foreign_key: "i_m__to_storage_location__c"

    validates_presence_of :name, :sfid, :account, :item, :i_m__amount__c, :createddate

    scope :for_configuration, ->(configuration) { where(item: configuration.get_related_items.pluck(:sfid)) }
    scope :for_category, ->(category) { where(item: category.items.pluck(:sfid)) if category.present? }  
    scope :for_account, ->(account) { where(account: account) }
    scope :for_item, ->(item) { where(item: item) }
end