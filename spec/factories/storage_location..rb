FactoryGirl.define do
  factory :storage_location do |f|
    f.sfid  { Faker::Number.number(10) }
    f.name  { Faker::Commerce.product_name }
  end
end