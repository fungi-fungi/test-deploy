class CategorySet < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__category_set__c'

  validates :name, :sfid, presence: true
end