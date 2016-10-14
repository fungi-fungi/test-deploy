FactoryGirl.define do
  factory :request_entity do |f|
    f.name              { "RE-#{Faker::Number.number(5)}" }
    f.i_m__amount__c    { Faker::Number.number(3) }
    f.i_m__provider__c  { 'rental' }
    association         :item, factory: :item
    association         :request_bom, factory: :request_bom

    factory :request_entities_with_stock do
      after(:create) { |entity| create(:stock_item, item: entity.item ) }
    end

    factory :request_entities_with_duplicates do
      after(:create) { |entity| create(:request_entity, item: entity.item ) }
    end

  end
end