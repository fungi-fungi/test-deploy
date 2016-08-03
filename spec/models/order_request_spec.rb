require 'rails_helper'

RSpec.describe OrderRequest, type: :model do
  
  it "has a valid factory" do
    expect(build(:order_request)).to be_valid
  end

  it "is invalid without a start date" do
    expect(build(:order_request, i_m__start_date__c: nil)).not_to be_valid
  end

  it "is invalid without a end date" do
    expect(build(:order_request, i_m__end_date__c: nil)).not_to be_valid
  end

  it "is invalid if start date after end date" do
    expect(build(:order_request, i_m__end_date__c: Time.now.yesterday, i_m__start_date__c: Time.now)).not_to be_valid
  end

 it "is invalid without a associated account" do
    expect(build(:order_request, account: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = OrderRequest.all.size
    create(:order_request)
    expect(OrderRequest.all.size).to eq(old_size + 1)
  end
end