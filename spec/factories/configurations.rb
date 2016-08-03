FactoryGirl.define do
  factory :configuration do |f|
    f.name        { Faker::Commerce.product_name }
    f.sfid        { Faker::Number.number(10) }
    association   :account, factory: :account
    association   :bom
    association   :category_set
  
    trait :iurii_configurations do
      association :account, Account.where(sfid: '0013600000NSyCRAA1').first
    end

    factory :category_belongs_to_iurii, traits: [:iurii_configurations]

  end
end