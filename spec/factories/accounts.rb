FactoryGirl.define do
  factory :account do
    name  { Faker::Name.name }
    sfid  { Faker::Number.number(10) }

    trait :venue do
      recordtypeid "01236000000salCAAQ"
    end

    trait :client do
      recordtypeid "01236000000salMAAQ"
    end

    factory :account_venue, traits: [:venue]
    factory :account_client, traits: [:client]
  end

end