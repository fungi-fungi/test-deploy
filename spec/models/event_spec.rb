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

  it "is invalid without a convention center" do
    expect(build(:event, i_m__convention_center__c: nil)).not_to be_valid
  end


  it "can be saved" do
    old_size = Event.all.size
    create(:event)
    expect(Event.all.size).to eq(old_size + 1)
  end
end