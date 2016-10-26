require 'rails_helper'

RSpec.describe SuggestedRentalSet, type: :model do

  it "has a valid factory" do
    expect(build(:suggested_rental_set)).to be_valid
  end

  it "is invalid without a sfid" do
    expect(build(:suggested_rental_set, sfid: nil)).not_to be_valid
  end

  it "is invalid without a name" do
    expect(build(:suggested_rental_set, name: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = SuggestedRentalSet.all.size
    create(:suggested_rental_set)
    expect(SuggestedRentalSet.all.size).to eq(old_size + 1)
  end

end