FactoryGirl.define do
  factory :stock_item do |f|
    f.name                { Faker::Commerce.product_name }
    f.sfid                { Faker::Number.number(10) }
    f.i_m__amount__c      { Faker::Number.number(3) } 
    f.i_m__location__c    { Faker::Commerce.department }
    f.createddate         { Faker::Time.between(10.days.ago, 2.days.ago) }
    association           :account, factory: :account
    association           :item, factory: :item

    trait :iurii_stock_items do
      association :account, Account.where(sfid: '0013600000NSyCRAA1').first
    end

    factory :stock_items_belongs_to_iurii, traits: [:iurii_stock_items]
    end
end