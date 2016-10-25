class Configuration < ActiveRecord::Base
  self.table_name = 'salesforce.i_m__configuration__c'

  belongs_to :account, primary_key: "sfid", foreign_key: "i_m__to_account__c"
  belongs_to :bom, primary_key: "sfid", foreign_key: "i_m__to_bom__c"
  belongs_to :category_set, primary_key: "sfid", foreign_key: "i_m__to_category_set__c"

  scope :search_by_name, ->(account, name) { name.size > 1 ? where(account: account).where("LOWER(name) LIKE ?", "%#{name.downcase}%") : none }

  def get_related_items
    self.bom.items
  end

  def get_related_entities
    self.bom.item_entities
  end

  validates_presence_of :name, :sfid, :account, :bom, :category_set
end