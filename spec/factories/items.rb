FactoryGirl.define do
  factory :item do |f|
    f.name          { Faker::Commerce.product_name }
    association     :category
  end
end