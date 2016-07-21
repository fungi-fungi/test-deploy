require 'rails_helper'

RSpec.describe Item, type: :model do
  
  it "has a valid factory" do
    expect(build(:item)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:item, name: nil)).not_to be_valid
  end

  it "is invalid without a category" do
    expect(build(:item, category: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = Item.all.size
    create(:item)
    expect(Item.all.size).to eq(old_size + 1)
  end
    
end
