FactoryGirl.define do
  factory :configuration do |f|
    f.name        { Faker::Commerce.product_name }
    f.sfid        { Faker::Number.number(10) }
    association   :account
    association   :bom
    association   :category_set
  end
end