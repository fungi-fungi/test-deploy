class OrderRequest < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__order_request__c'

  belongs_to :account, primary_key: 'sfid', foreign_key: 'i_m__to_account__c'
  belongs_to :request_bom, primary_key: "i_m__externalid__c", foreign_key: "i_m__to_request_bom__r__i_m__externalid__c"
  belongs_to :event, primary_key: "sfid", foreign_key: "i_m__to_event__c"
  belongs_to :configuration, primary_key: "sfid", foreign_key: "i_m__to_configuration__c"

  validates_associated :account, :request_bom, :event
  validates_presence_of :account, :request_bom, :event

  scope :belongs_to_overlap, lambda { |event| where(i_m__to_event__c: event.overlapping.pluck(:sfid)) }

  def get_related_items
    self.request_bom.items.uniq
  end

  def self.get_related_entities(sfids)
    OrderRequest.where(sfid: sfids).map { |order_request| order_request.request_bom.request_entities }.flatten
  end
  
end