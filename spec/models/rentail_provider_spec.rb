require 'rails_helper'

RSpec.describe RentalProvider, type: :model do
  
  it "has a valid factory" do
    expect(build(:rental_provider)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:rental_provider, name: nil)).not_to be_valid
  end

  it "is invalid without sfid" do
    expect(build(:rental_provider, sfid: nil)).not_to be_valid
  end

  it "is invalid without account" do
    expect(build(:rental_provider,account: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = RentalProvider.all.size
    create(:rental_provider)
    expect(RentalProvider.all.size).to eq(old_size + 1)
  end

end