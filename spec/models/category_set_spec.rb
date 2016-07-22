require 'rails_helper'

RSpec.describe CategorySet, type: :model do
  
  it "has a valid factory" do
    expect(build(:category_set)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:category_set, name: nil)).not_to be_valid
  end

  it "is invalid without sfid" do
    expect(build(:category_set, sfid: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = CategorySet.all.size
    create(:category_set)
    expect(CategorySet.all.size).to eq(old_size + 1)
  end

end