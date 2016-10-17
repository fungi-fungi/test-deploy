require 'rails_helper'

RSpec.describe StorageLocation, type: :model do
  
  it "has a valid factory" do
    expect(build(:storage_location)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:storage_location, name: nil)).not_to be_valid
  end

  it "is invalid without sfid" do
    expect(build(:storage_location, sfid: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = StorageLocation.all.size
    create(:storage_location)
    expect(StorageLocation.all.size).to eq(old_size + 1)
  end

end