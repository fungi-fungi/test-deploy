FactoryGirl.define do
  factory :category do |f|
    f.sfid { Faker::Number.number(10) }
    f.name { Faker::Commerce.product_name }
  end
end