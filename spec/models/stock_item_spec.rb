require 'rails_helper'

RSpec.describe StockItem, type: :model do
  
  it "has a valid factory" do
    expect(build(:stock_item)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:stock_item, name: nil)).not_to be_valid
  end

  it "is invalid without sfid" do
    expect(build(:stock_item, sfid: nil)).not_to be_valid
  end

  it "is invalid without a item" do
    expect(build(:stock_item, item: nil)).not_to be_valid
  end

  it "is invalid without account" do
    expect(build(:stock_item, account: nil)).not_to be_valid
  end

  it "is invalid without location" do
    expect(build(:stock_item, i_m__location__c: nil)).not_to be_valid
  end

  it "is invalid without amount" do
    expect(build(:stock_item, i_m__amount__c: nil)).not_to be_valid
  end

  it "is invalid without a create date" do
    expect(build(:item, createddate: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = Item.all.size
    create(:stock_item)
    expect(Item.all.size).to eq(old_size + 1)
  end

end