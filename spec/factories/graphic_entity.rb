FactoryGirl.define do
  factory :graphic_entity do
    name          { Faker::Commerce.product_name }
    sfid          { Faker::Number.number(10) }
    association   :graphics_set, factory: :graphics_set
    association   :item, factory: :item
  end
end