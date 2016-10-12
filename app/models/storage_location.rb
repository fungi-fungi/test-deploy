class StorageLocation < ActiveRecord::Base
    self.table_name = 'salesforce.i_m__storage_location__c'

    validates_presence_of :name, :sfid
end