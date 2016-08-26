class Api::V1::EventSerializer < ActiveModel::Serializer
  attributes :id, :sfid, :name, :startDate, :endDate, :city, :venue
  
  def venue 
    object.account.name
  end

  def startDate 
    object.i_m__start_date__c
  end

  def endDate 
    object.i_m__end_date__c
  end

  def city 
    object.i_m__city__c
  end
end