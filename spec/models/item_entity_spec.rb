require 'rails_helper'

RSpec.describe ItemEntity, type: :model do
  
  it "has a valid factory" do
    expect(build(:item_entity)).to be_valid
  end

  it "is invalid without a sfid" do
    expect(build(:item_entity, sfid: nil)).not_to be_valid
  end

  it "is invalid without a name" do
    expect(build(:item_entity, name: nil)).not_to be_valid
  end

  it "is invalid without a ammount" do
    expect(build(:item_entity, i_m__amount__c: nil)).not_to be_valid
  end

  it "is invalid without a associated item" do
    expect(build(:item_entity, item: nil)).not_to be_valid
  end

  it "is invalid without a associated bom" do
    expect(build(:item_entity, bom: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = ItemEntity.all.size
    create(:item_entity)
    expect(ItemEntity.all.size).to eq(old_size + 1)
  end
end
