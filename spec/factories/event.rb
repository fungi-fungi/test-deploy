FactoryGirl.define do
  factory :event do |f|
    f.name                        { "SE-#{Faker::Number.number(5)}" }
    f.sfid                        { Faker::Number.number(10) }
    f.i_m__city__c                { Faker::Address.city }
    f.i_m__start_date__c          { Faker::Time.between(12.days.ago, 7.days.ago) }
    f.i_m__end_date__c            { Faker::Time.between(4.days.ago, Date.today) }
    association                   :account, factory: :account_venue

    factory :event_overlap do 
      
      transient do
        overlap_amount 0
      end

      transient do
        non_overlap_amount 0
      end

      after(:create) do |event, evaluator|

        evaluator.overlap_amount.times do |x|
          
          # Left
          create(
            :event,
            account: event.account,
            i_m__start_date__c: Faker::Time.between(event.i_m__start_date__c - 7.day, event.i_m__start_date__c - 1.day),
            i_m__end_date__c: Faker::Time.between(event.i_m__start_date__c + 1.day, event.i_m__end_date__c - 1.day)
          )

          create(
            :event,
            account: event.account,
            i_m__start_date__c: Faker::Time.between(event.i_m__start_date__c + 1.day, event.i_m__start_date__c + 2.day),
            i_m__end_date__c: Faker::Time.between(event.i_m__end_date__c - 2.day, event.i_m__end_date__c - 1.day)
          )

          # Right
          create(
            :event,
            account: event.account,
            i_m__start_date__c: Faker::Time.between(event.i_m__start_date__c + 1.day, event.i_m__end_date__c - 1.day),
            i_m__end_date__c: Faker::Time.between(event.i_m__end_date__c + 1.day, event.i_m__end_date__c + 5.day)
          )

          # Out
          create(
            :event,
            account: event.account,
            i_m__start_date__c: Faker::Time.between(event.i_m__start_date__c - 5.day, event.i_m__start_date__c - 1.day),
            i_m__end_date__c: Faker::Time.between(event.i_m__end_date__c + 1.day, event.i_m__end_date__c + 5.day)
          )

        end

        evaluator.non_overlap_amount.times do |x|
          
          # Before
          create(
            :event,
            account: event.account,
            i_m__start_date__c: Faker::Time.between(event.i_m__start_date__c - 30.day, event.i_m__start_date__c - 15.day),
            i_m__end_date__c: Faker::Time.between(event.i_m__start_date__c - 14.day, event.i_m__start_date__c - 2.day)
          )

          # After
          create(
            :event,
            account: event.account,
            i_m__start_date__c: Faker::Time.between(event.i_m__end_date__c + 2.day, event.i_m__end_date__c + 5.day),
            i_m__end_date__c: Faker::Time.between(event.i_m__end_date__c + 7.day, event.i_m__end_date__c + 15.day)
          )
        end

      end

    end

  end

end