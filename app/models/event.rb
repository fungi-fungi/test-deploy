class Event < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__show_and_event__c'

  has_many :order_requests, primary_key: 'sfid', foreign_key: 'i_m__to_event__c'
  belongs_to :account, primary_key: 'sfid', foreign_key: 'i_m__convention_center__c'

  validates_presence_of :name, :sfid, :account, :i_m__start_date__c, :i_m__end_date__c, :i_m__city__c
  validate :start_date_has_to_be_before_end_date, :account_should_be_venue

  def overlapping
    Event.where('(i_m__start_date__c, i_m__end_date__c) overlaps (timestamp :start, timestamp :end)', start: self.i_m__start_date__c, end: self.i_m__end_date__c)
  end

  private
  
  def start_date_has_to_be_before_end_date
    if self.i_m__start_date__c.present? && self.i_m__end_date__c.present? && self.i_m__start_date__c > self.i_m__end_date__c
      errors.add(:date_error, "start date can't be before end date'")
    end
  end

  def account_should_be_venue
    if self.account
      if self.account.recordtypeid == nil || self.account.recordtypeid != "01236000000salCAAQ"
        errors.add(:date_error, "account should be a venue")
      end
    end
  end
end