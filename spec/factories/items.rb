FactoryGirl.define do
  factory :item do |f|
    f.name          { Faker::Commerce.product_name }
    f.createddate   { Faker::Time.between(10.days.ago, 2.days.ago) }
    association     :category
  end
end