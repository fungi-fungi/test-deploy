FactoryGirl.define do
  factory :request_bom do |f|
    f.name                  { "RO-#{Faker::Number.number(5)}" }

    factory :request_bom_with_entities do
      after(:create) { |request_bom| create_list(:request_entity, 10, request_bom: request_bom) }
    end

    factory :request_bom_for_exisiting_items_random do

      transient do
        existing_items []
      end

      transient do
        amount_of_items 0
      end

      after(:create) do |request_bom, evaluator|

        evaluator.amount_of_items.times do |item|
          create(:request_entity, request_bom: request_bom, item: evaluator.existing_items.sample )
        end

      end
    end

    factory :request_bom_for_exisiting_items do

      transient do
        existing_items []
      end

      after(:create) do |request_bom, evaluator|

        evaluator.existing_items.each do |item|
          create(:request_entity, request_bom: request_bom, item: item )
        end

      end 
    end

  end
end