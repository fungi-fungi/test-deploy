class ItemEntity < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__item_entity__c'

  belongs_to :bom, primary_key: 'sfid', foreign_key: 'i_m__to_bom__c'
  belongs_to :item, primary_key: 'sfid', foreign_key: 'i_m__to_item__c'
  
  validates_presence_of :sfid, :name, :i_m__amount__c, :bom, :item

  def self.build_item_id_map(collection)
    ItemEntity.all.inject(Hash.new) do |hash, el|
      hash.has_key?(el.i_m__to_item__c) ? hash[el.i_m__to_item__c] = hash[el.i_m__to_item__c] + el.i_m__amount__c : hash[el.i_m__to_item__c] = el.i_m__amount__c
      hash
    end
  end

end
