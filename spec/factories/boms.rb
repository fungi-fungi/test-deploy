FactoryGirl.define do
  factory :bom do |f|
    f.name      { Faker::Commerce.product_name }
    f.sfid      { Faker::Number.number(10) }
  end
end