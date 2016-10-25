FactoryGirl.define do
  factory :item do
    sfid          { Faker::Number.number(10) }
    name          { Faker::Commerce.product_name }
    createddate   { Faker::Time.between(10.days.ago, 2.days.ago) }
    association   :category
  end
end