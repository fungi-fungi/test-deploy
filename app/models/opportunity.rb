class Opportunity < ActiveRecord::Base
  self.table_name = 'salesforce.opportunity'

  has_many :orders, primary_key: "sfid", foreign_key: "i_m__related_opportunity__c"
  has_one :order_request, primary_key: "sfid", foreign_key: "i_m__to_opportunity__c"
  belongs_to :account, primary_key: "sfid", foreign_key: "accountid"
  
  validates_presence_of :sfid, :name

  def self.overlapping(event)
    Opportunity.where(
      '(i_m__golden_targeted_shipping_date__c, i_m__golden_anticipated_return_date__c)
       overlaps
       (timestamp :start, timestamp :end)', start: event.i_m__start_date__c, end: event.i_m__end_date__c)
  end

  def self.overlapping_order_requests_sfids(event)
    Opportunity.overlapping(event).map { |opportunity| opportunity.order_request.nil? ? opportunity.order_request.sfid : nil }
  end

end