FactoryGirl.define do
  factory :order_request do |f|
    f.name                  { "REQ-#{Faker::Number.number(5)}" }
    association             :account
    association             :event
    association             :request_bom
  end
end