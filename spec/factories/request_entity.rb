FactoryGirl.define do
  factory :request_entity do |f|
    f.name              { "RE-#{Faker::Number.number(5)}" }
    f.i_m__amount__c    { Faker::Number.number(3) }
    association         :item, factory: :item
  end
end