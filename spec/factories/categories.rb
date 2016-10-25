FactoryGirl.define do
  factory :category do
    sfid  { Faker::Number.number(10) }
    name  { Faker::Commerce.product_name }
  end
end