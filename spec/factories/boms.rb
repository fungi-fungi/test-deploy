FactoryGirl.define do
  factory :bom do |f|
    f.name      { Faker::Commerce.product_name }
    f.sfid      { Faker::Number.number(10) }

    factory :bom_with_entities do
      after(:create) { |bom| create_list(:item_entity, 10, bom: bom) }
    end
  end
end