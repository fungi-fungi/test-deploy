FactoryGirl.define do
  factory :account do |f|
    f.name  { Faker::Name.name }
    f.sfid  { Faker::Number.number(10) }

    trait :venue do |f|
      f.recordtypeid "01236000000salCAAQ"
    end

    trait :client do |f|
      f.recordtypeid "01236000000salMAAQ"
    end

    factory :account_venue, traits: [:venue]
    factory :account_client, traits: [:client]
  end

end