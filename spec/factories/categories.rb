FactoryGirl.define do
  factory :category do |f|
    f.sfid                { Faker::Number.number(10) }
    f.name                { Faker::Commerce.product_name }
    f.i_m__externalid__c  { Faker::Number.number(10) }
  end
end