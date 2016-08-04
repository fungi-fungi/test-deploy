FactoryGirl.define do
  factory :category_set do |f|
    f.name      { Faker::Commerce.product_name }
    f.sfid      { Faker::Number.number(10) }

    factory :category_set_with_entities do
      after(:create) { |category_set| create_list(:category_entity, 10, category_set: category_set) }
    end
  end
end