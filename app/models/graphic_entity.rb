class GraphicEntity < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__graphic_entity__c'
  
  belongs_to :item, primary_key: "sfid", foreign_key: "i_m__to_item__c"
  belongs_to :graphics_set, primary_key: "sfid", foreign_key: "i_m__to_graphics_set__c"

  validates_presence_of :sfid, :name, :item, :graphics_set
end