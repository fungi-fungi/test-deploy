FactoryGirl.define do
  factory :category_set do |f|
    f.name      { Faker::Commerce.product_name }
    f.sfid      { Faker::Number.number(10) }
  end
end