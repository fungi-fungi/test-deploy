require 'rails_helper'

RSpec.describe SuggestedRentalEntity, type: :model do

  it "has a valid factory" do
    expect(build(:suggested_rental_entity)).to be_valid
  end

  it "is invalid without a sfid" do
    expect(build(:suggested_rental_entity, sfid: nil)).not_to be_valid
  end

  it "is invalid without a name" do
    expect(build(:suggested_rental_entity, name: nil)).not_to be_valid
  end

  it "is invalid without rental set" do
    expect(build(:suggested_rental_set, name: nil)).not_to be_valid
  end

  it "is invalid without item reference" do
    expect(build(:item, name: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = SuggestedRentalEntity.all.size
    create(:suggested_rental_entity)
    expect(SuggestedRentalEntity.all.size).to eq(old_size + 1)
  end

end