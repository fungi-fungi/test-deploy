FactoryGirl.define do
  factory :configuration do |f|
    f.name        { Faker::Commerce.product_name }
    f.sfid        { Faker::Number.number(10) }
    association   :account, factory: :account
    association   :bom, factory: :bom
    association   :category_set, factory: :category_set

    trait :iurii_configurations do
      account { Account.first_or_create(sfid: '0013600000NSyCRAA1') }
    end

    trait :with_sets do
      association :bom, factory: :bom_with_entities
      association :category_set, factory: :category_set_with_entities
    end

    factory :configuration_belongs_to_iurii, traits: [:iurii_configurations]
    factory :configuration_with_sets_iurii, traits: [:iurii_configurations, :with_sets]
    factory :configuration_with_sets, traits: [:with_sets]
    

  end
end