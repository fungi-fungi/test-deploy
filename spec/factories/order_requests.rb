FactoryGirl.define do
  factory :order_request do |f|
    f.name                  { "REQ-#{Faker::Number.number(5)}" }
    f.i_m__start_date__c    { Faker::Time.between(10.days.ago, 5.days.ago) }
    f.i_m__end_date__c      { Faker::Time.between(4.days.ago, Date.today) }
    association             :account
  end
end