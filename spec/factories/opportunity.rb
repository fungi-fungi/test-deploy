FactoryGirl.define do
  factory :opportunity do
    sfid          { Faker::Number.number(10) }
    name          { Faker::Commerce.product_name }
    createddate   { Faker::Time.between(10.days.ago, 2.days.ago) }
    association   :order_request

    trait :iurii_configurations do
      account { Account.first_or_create(sfid: '0013600000NSyCRAA1') }
    end

    trait :opportunity_with_order_request do
      association :order_request, factory: :order_request_with_sets_iurii
    end

    trait :month_long_publishing do
      start_at { 1.month.ago }
      end_at   { Time.now }
    end


    factory :opportunities_with_overlap do 
      
      transient do
        overlap_amount 0
      end

      transient do
        non_overlap_amount 0
      end

      transient do
        start_date '21-12-2006'
      end

      transient do
        end_date '22-12-2006'
      end


      after(:create) do |event, evaluator|
        
        start_date = (evaluator.start_date)
        end_date = (evaluator.end_date)

        evaluator.overlap_amount.times do

          args_left = {
            i_m__golden_targeted_shipping_date__c: Faker::Time.between(start_date - 7.day, end_date - 1.day),
            i_m__golden_anticipated_return_date__c: Faker::Time.between(start_date + 1.day, end_date - 1.day)
          }

          args_in = {
            i_m__golden_targeted_shipping_date__c: Faker::Time.between(start_date - 7.day, start_date - 1.day),
            i_m__golden_anticipated_return_date__c: Faker::Time.between(start_date + 1.day, end_date - 1.day)
          }

          args_right = {
            i_m__golden_targeted_shipping_date__c: Faker::Time.between(start_date + 1.day, end_date - 1.day),
            i_m__golden_anticipated_return_date__c: Faker::Time.between(end_date + 1.day, end_date + 5.day)
          }

          args_out = {
            i_m__golden_targeted_shipping_date__c: Faker::Time.between(start_date - 5.day, start_date - 1.day),
            i_m__golden_anticipated_return_date__c: Faker::Time.between(end_date + 1.day, end_date + 5.day)
          }

          create :opportunity, args_right
          create :opportunity, args_left
          create :opportunity, args_in
          create :opportunity, args_out
        end

        evaluator.non_overlap_amount.times do
          
          args_before = {
            i_m__golden_targeted_shipping_date__c: Faker::Time.between(start_date - 30.day, start_date - 15.day),
            i_m__golden_anticipated_return_date__c: Faker::Time.between(start_date - 14.day, start_date - 2.day)
          }

          args_after = {
            i_m__golden_targeted_shipping_date__c: Faker::Time.between(end_date + 2.day, end_date + 5.day),
            i_m__golden_anticipated_return_date__c: Faker::Time.between(end_date + 7.day, end_date + 15.day)
          }

        create :opportunity, args_before
        create :opportunity, args_after

        end

      end

    end

  end
end