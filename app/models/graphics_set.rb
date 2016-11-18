class GraphicsSet < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__graphics_set__c'
  
  belongs_to :configuration, primary_key: "sfid", foreign_key: "i_m__to_configuration__c"
  has_many :graphic_entities, primary_key: "sfid", foreign_key: "i_m__to_graphics_set__c"

  validates_presence_of :sfid, :name, :configuration
end