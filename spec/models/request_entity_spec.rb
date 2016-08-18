require 'rails_helper'

RSpec.describe RequestEntity, type: :model do
  
  it "has a valid factory" do
    expect(build(:request_entity)).to be_valid
  end

  it "is invalid without name" do
    expect(build(:request_entity, name: nil)).not_to be_valid
  end

  it "is invalid without amount" do
    expect(build(:request_entity, i_m__amount__c: nil)).not_to be_valid
  end

  it "is invalid if amount less then 0" do
    expect(build(:request_entity, i_m__amount__c: -1)).not_to be_valid
  end

  it "is invalid if amount is 0" do
    expect(build(:request_entity, i_m__amount__c: 0)).not_to be_valid
  end

  it "is invalid if no item specified" do
    expect(build(:request_entity, item: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = RequestEntity.all.size
    create(:request_entity)
    expect(RequestEntity.all.size).to eq(old_size + 1)
  end
end