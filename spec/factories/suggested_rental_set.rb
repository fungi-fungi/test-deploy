FactoryGirl.define do
  factory :suggested_rental_set do
    sfid  { Faker::Number.number(10) }
    name  { Faker::Commerce.product_name }
  end
end