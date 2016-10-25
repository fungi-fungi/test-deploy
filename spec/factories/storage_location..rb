FactoryGirl.define do
  factory :storage_location do
    sfid  { Faker::Number.number(10) }
    name  { Faker::Commerce.product_name }
  end
end