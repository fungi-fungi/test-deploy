FactoryGirl.define do
  factory :configuration do |f|
    f.name        { Faker::Commerce.product_name }
    f.sfid        { Faker::Number.number(10) }
    f.account     Account.where(sfid: '0013600000NSyCRAA1').first
    association   :bom
    association   :category_set
  end

  trait :iurii do
    association :account, Account.where(sfid: '0013600000NSyCRAA1').first
  end

  factory :category_belongs_to_iurii, traits: [:iurii]
end