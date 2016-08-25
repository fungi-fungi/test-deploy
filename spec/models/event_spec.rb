require 'rails_helper'

RSpec.describe Event, type: :model do
  
  it "has a valid factory" do
    expect(build(:event)).to be_valid
  end

  it "is invalid without name" do
    expect(build(:event, name: nil)).not_to be_valid
  end

  it "is invalid without sfid" do
    expect(build(:event, sfid: nil)).not_to be_valid
  end

  it "is invalid without a convention center" do
    expect(build(:event, account: nil)).not_to be_valid
  end

  it "is invalid if account is not a venue type" do
    expect(build(:event, account: FactoryGirl.create(:account_client))).not_to be_valid
  end

  it "is invalid without start date" do
    expect(build(:event, i_m__start_date__c: nil)).not_to be_valid
  end

  it "is invalid without end date" do
    expect(build(:event, i_m__end_date__c: nil)).not_to be_valid
  end

  it "is invalid if start date after end date" do
    expect(build(:event, i_m__end_date__c: Time.now.yesterday, i_m__start_date__c: Time.now)).not_to be_valid
  end

  it "is invalid without city location" do
    expect(build(:event, i_m__city__c: nil)).not_to be_valid
  end

  it "returns all overlaping events" do
    number_of_overlaping_evants = 3
    number_possible_overlap_cases = 4
    create(:event_overlap, overlap_amount: number_of_overlaping_evants, non_overlap_amount: 10)
    expect(Event.first.overlapping.count).to be_equal(number_of_overlaping_evants * number_possible_overlap_cases + 1)
  end

  it "can be saved" do
    old_size = Event.all.size
    create(:event)
    expect(Event.all.size).to eq(old_size + 1)
  end
end