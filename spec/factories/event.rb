FactoryGirl.define do
  factory :event do |f|
    f.name                        { "SE-#{Faker::Number.number(5)}" }
    f.sfid                        { Faker::Number.number(10) }
    f.i_m__city__c                { Faker::Address.city }
    f.i_m__start_date__c          { Faker::Time.between(10.days.ago, 5.days.ago) }
    f.i_m__end_date__c            { Faker::Time.between(4.days.ago, Date.today) }
    association                   :account, factory: :account_venue
  end
end