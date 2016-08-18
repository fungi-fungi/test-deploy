FactoryGirl.define do
  factory :order_request do |f|
    f.name                  { "REQ-#{Faker::Number.number(5)}" }
    association             :account

    trait :order_with_sfid do |f|
      f.sfid                { Faker::Number.number(10) }
    end

    factory :order_with_sfid, traits: [:order_with_sfid]
  end
end