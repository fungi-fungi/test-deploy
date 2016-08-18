class OrderRequest < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__order_request__c'

  belongs_to :account, primary_key: 'sfid', foreign_key: 'i_m__to_account__c'

  validates_presence_of :account
  
  private
  
  def start_date_has_to_be_before_end_date
    if self.i_m__start_date__c.present? && self.i_m__end_date__c.present? && self.i_m__start_date__c > self.i_m__end_date__c
      errors.add(:date_error, "start date can't be before end date'")
    end
  end    
end
