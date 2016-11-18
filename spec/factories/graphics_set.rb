FactoryGirl.define do
  factory :graphics_set do
    name          { Faker::Commerce.product_name }
    sfid          { Faker::Number.number(10) }
    association   :configuration, factory: :configuration
  end
end