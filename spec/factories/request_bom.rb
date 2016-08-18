FactoryGirl.define do
  factory :request_bom do |f|
    f.name                  { "RO-#{Faker::Number.number(5)}" }
  end
end