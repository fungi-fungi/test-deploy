FactoryGirl.define do
  factory :stock_item do
    name            { Faker::Commerce.product_name }
    sfid            { Faker::Number.number(10) }
    i_m__amount__c  { Faker::Number.number(3) } 
    createddate     { Faker::Time.between(10.days.ago, 2.days.ago) }
    association     :account, factory: :account
    association     :item, factory: :item
    association     :storage_location

    trait :iurii_stock_items do
      account { Account.first_or_create(sfid: '0013600000NSyCRAA1') }
    end

    factory :stock_item_belongs_to_iurii, traits: [:iurii_stock_items] 
  
  end
end