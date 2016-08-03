class Api::V1::OrderRequestSerializer < ActiveModel::Serializer
  attributes :id, :sfid, :start_date, :end_date

  def start_date
    object.i_m__start_date__c
  end

  def end_date
    object.i_m__end_date__c
  end
end