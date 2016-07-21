require 'rails_helper'

RSpec.describe Category, type: :model do
  
  it "has a valid factory" do
    expect(build(:category)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:category, name: nil)).not_to be_valid
  end

  it "is invalid without external index" do
    expect(build(:category, i_m__externalid__c: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = Category.all.size
    create(:category)
    expect(Category.all.size).to eq(old_size + 1)
  end

end
