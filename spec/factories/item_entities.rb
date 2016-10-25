FactoryGirl.define do
  factory :item_entity do
    sfid              { Faker::Number.number(10) }
    name              { "IMI-#{Faker::Number.number(5)}" }
    i_m__amount__c    { Faker::Number.number(3) }
    association       :bom, factory: :bom
    association       :item, factory: :item

    factory :entities_with_stock do
      after(:create) { |entity| create(:stock_item, item: entity.item ) }
    end

    factory :item_entities_with_duplicates do
      after(:create) { |entity| create(:item_entity, item: entity.item ) }
    end

  end
end