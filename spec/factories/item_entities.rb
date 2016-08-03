FactoryGirl.define do
  factory :item_entity do |f|
    f.sfid              { Faker::Number.number(10) }
    f.name              { "IMI-#{Faker::Number.number(5)}" }
    f.i_m__amount__c    { Faker::Number.number(3) }
    association         :bom, factory: :bom
    association         :item, factory: :item
  end
end