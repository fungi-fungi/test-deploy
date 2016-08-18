require 'rails_helper'

RSpec.describe RequestBom, type: :model do
  
  it "has a valid factory" do
    expect(build(:request_bom)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:request_bom, name: nil)).not_to be_valid
  end

  it "is invalid without a exteran id" do
    expect(build(:request_bom, i_m__externalid__c: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = RequestBom.all.size
    create(:request_bom)
    expect(RequestBom.all.size).to eq(old_size + 1)
  end
end