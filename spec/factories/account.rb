FactoryGirl.define do
  factory :account do |f|
    f.name  { Faker::Name.name }
    f.sfid  { Faker::Number.number(10) }
  end
end