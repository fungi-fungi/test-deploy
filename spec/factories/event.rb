FactoryGirl.define do
  factory :event do |f|
    name                        { "SE-#{Faker::Number.number(5)}" }
    sfid                        { Faker::Number.number(10) }
    i_m__city__c                { Faker::Address.city }
    i_m__start_date__c          { Faker::Time.between(20.days.ago, 15.days.ago) }
    i_m__end_date__c            { Faker::Time.between(10.days.ago, Time.zone.today) }
    association                 :account, factory: :account_venue

    factory :event_name_overlap do

      transient do
        overlap_amount 0
      end

      transient do
        non_overlap_amount 0
      end

      after(:create) do |event, evaluator|
        evaluator.overlap_amount.times do
          create :event, name: "#{Faker::Number.number(3)}#{event.name}"
        end

        evaluator.non_overlap_amount.times do
          create :event, name: "#{Faker::Company.name}.gsub(event.name, '')"
        end
      end
      
    end

    factory :event_overlap do 
      
      transient do
        overlap_amount 0
      end

      transient do
        non_overlap_amount 0
      end

      after(:create) do |event, evaluator|
        
        evaluator.overlap_amount.times do

          args_left = {
            account: event.account, 
            i_m__start_date__c: Faker::Time.between(event.i_m__start_date__c - 7.day, event.i_m__start_date__c - 1.day),
            i_m__end_date__c: Faker::Time.between(event.i_m__start_date__c + 1.day, event.i_m__end_date__c - 1.day)
          }

          args_in = {
            account: event.account,
            i_m__start_date__c: Faker::Time.between(event.i_m__start_date__c - 7.day, event.i_m__start_date__c - 1.day),
            i_m__end_date__c: Faker::Time.between(event.i_m__start_date__c + 1.day, event.i_m__end_date__c - 1.day)
          }

          args_right = {
            account: event.account,
            i_m__start_date__c: Faker::Time.between(event.i_m__start_date__c + 1.day, event.i_m__end_date__c - 1.day),
            i_m__end_date__c: Faker::Time.between(event.i_m__end_date__c + 1.day, event.i_m__end_date__c + 5.day)
          }

          args_out = {
            account: event.account,
            i_m__start_date__c: Faker::Time.between(event.i_m__start_date__c - 5.day, event.i_m__start_date__c - 1.day),
            i_m__end_date__c: Faker::Time.between(event.i_m__end_date__c + 1.day, event.i_m__end_date__c + 5.day)
          }

          create :event, args_right
          create :event, args_left
          create :event, args_in
          create :event, args_out
        end

        evaluator.non_overlap_amount.times do
          
          args_before = {
            account: event.account,
            i_m__start_date__c: Faker::Time.between(event.i_m__start_date__c - 30.day, event.i_m__start_date__c - 15.day),
            i_m__end_date__c: Faker::Time.between(event.i_m__start_date__c - 14.day, event.i_m__start_date__c - 2.day)
          }

          args_after = {
            account: event.account,
            i_m__start_date__c: Faker::Time.between(event.i_m__end_date__c + 2.day, event.i_m__end_date__c + 5.day),
            i_m__end_date__c: Faker::Time.between(event.i_m__end_date__c + 7.day, event.i_m__end_date__c + 15.day)
          }

        create :event, args_before
        create :event, args_after

        end

      end

    end

  end

end