FactoryGirl.define do
  factory :stock_item do |f|
    f.name                { Faker::Commerce.product_name }
    f.i_m__amount__c      { Faker::Number.number(3) } 
    f.i_m__location__c    { Faker::Commerce.department }
    association           :account
    association           :item
  end
end