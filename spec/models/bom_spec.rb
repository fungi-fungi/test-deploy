require 'rails_helper'

RSpec.describe Bom, type: :model do
  
  it "has a valid factory" do
    expect(build(:bom)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:bom, name: nil)).not_to be_valid
  end

  it "is invalid without sfid" do
    expect(build(:bom, sfid: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = Bom.all.size
    create(:bom)
    expect(Bom.all.size).to eq(old_size + 1)
  end

end