FactoryGirl.define do
  factory :rental_provider do |f|
    f.sfid          { Faker::Number.number(10) }
    f.name          { Faker::Commerce.product_name }
    association     :account
  end
end