class StockItem < ActiveRecord::Base
    self.table_name = 'salesforce.i_m__stock_item__c'
    
    belongs_to :account, primary_key: "sfid", foreign_key: "i_m__to_account__c"
    belongs_to :item, primary_key: "sfid", foreign_key: "i_m__to_item__c"

    validates_presence_of :name, :sfid, :account, :item, :i_m__amount__c, :i_m__location__c, :createddate

    scope :for_configuration, lambda { |configuration| where(item: configuration.get_related_items.pluck(:sfid)) }

    def self.get_stock_for_configuration(event, configuration)
        available_stock(configuration, get_order_request_items(event))
    end

    private

    # TODO: refactor
    def self.available_stock(configuration, order_requests)
    
        avalaible_stock = []
        
        StockItem.for_configuration(configuration).each do |entity|
            amount = order_requests[entity.item.sfid].nil? ? entity.i_m__amount__c : entity.i_m__amount__c - order_requests[entity.item.sfid] 
            avalaible_stock << AvaliableStock.new(item: entity.item.sfid, amount: amount)
        end
        
        avalaible_stock
    end

    def self.get_order_request_items(event)
        RequestEntity.build_item_id_map(OrderRequest.get_related_entities(OrderRequest.belongs_to_overlap(event).pluck(:sfid)))
    end

end