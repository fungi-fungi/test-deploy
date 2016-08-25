FactoryGirl.define do
  factory :request_bom do |f|
    f.name                  { "RO-#{Faker::Number.number(5)}" }

    factory :request_bom_with_entities do
      after(:create) { |request_bom| create_list(:request_entity, 10, request_bom: request_bom) }
    end

  end
end