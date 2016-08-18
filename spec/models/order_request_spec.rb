require 'rails_helper'

RSpec.describe OrderRequest, type: :model do
  
  it "has a valid factory" do
    expect(build(:order_request)).to be_valid
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