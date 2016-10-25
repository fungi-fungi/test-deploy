FactoryGirl.define do
  factory :rental_provider do
    sfid          { Faker::Number.number(10) }
    name          { Faker::Commerce.product_name }
    association     :account
  end
end