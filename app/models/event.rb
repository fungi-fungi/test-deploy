class Event < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__show_and_event__c'

  has_many :item_entities, primary_key: 'sfid', foreign_key: 'i_m__to_event__c'

  validates_presence_of :name, :sfid, :i_m__start_date__c, :i_m__end_date__c, :i_m__city__c, :i_m__convention_center__c
  validate :start_date_has_to_be_before_end_date

  private
  
  def start_date_has_to_be_before_end_date
    if self.i_m__start_date__c.present? && self.i_m__end_date__c.present? && self.i_m__start_date__c > self.i_m__end_date__c
      errors.add(:date_error, "start date can't be before end date'")
    end
  end 
end