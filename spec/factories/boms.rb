FactoryGirl.define do
  factory :bom do |f|
    f.name      { Faker::Commerce.product_name }
    f.sfid      { Faker::Number.number(10) }

    factory :bom_with_entities do
      after(:create) { |bom| create_list(:item_entity, 10, bom: bom) }
    end

    factory :bom_for_exisiting_items_random do

      transient do
        existing_items []
      end

      transient do
        amount_of_items 0
      end

      after(:create) do |bom, evaluator|

        evaluator.amount_of_items.times do |item|
          create(:item_entity, bom: bom, item: evaluator.existing_items.sample )
        end

      end 
    end
    
  end
end