FactoryGirl.define do
  factory :category_entity do
    sfid              { Faker::Number.number(10) }
    name              { "IMC-#{Faker::Number.number(5)}" }
    association       :category_set, factory: :category_set
    association       :category, factory: :category
  end
end