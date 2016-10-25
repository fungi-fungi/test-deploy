FactoryGirl.define do
  factory :order_request do
    name                  { "REQ-#{Faker::Number.number(5)}" }
    sfid                  { Faker::Number.number(10) }
    association           :account
    association           :event
    association           :request_bom

    trait :iurii_order_request do
      account { Account.first_or_create(sfid: '0013600000NSyCRAA1') }
    end

    trait :order_request_with_sets do
      association :request_bom, factory: :request_bom_with_entities
    end

    factory :order_request_belongs_to_iurii, traits: [:iurii_order_request]
    factory :order_request_with_sets, traits: [:order_request_with_sets]
    factory :order_request_with_sets_iurii, traits: [:iurii_order_request, :order_request_with_sets]
  end
end