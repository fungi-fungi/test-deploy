FactoryGirl.define do
  factory :suggested_rental_entity do
    sfid          { Faker::Number.number(10) }
    name          { Faker::Commerce.product_name }
    association   :suggested_rental_set
    association   :item
  end
end