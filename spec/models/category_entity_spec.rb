require 'rails_helper'

RSpec.describe CategoryEntity, type: :model do
  
  it "has a valid factory" do
    expect(build(:category_entity)).to be_valid
  end

  it "is invalid without a sfid" do
    expect(build(:category_entity, sfid: nil)).not_to be_valid
  end

  it "is invalid without a name" do
    expect(build(:category_entity, name: nil)).not_to be_valid
  end

  it "is invalid without a associated category" do
    expect(build(:category_entity, category: nil)).not_to be_valid
  end

  it "is invalid without a associated category set" do
    expect(build(:category_entity, category_set: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = CategoryEntity.all.size
    create(:category_entity)
    expect(CategoryEntity.all.size).to eq(old_size + 1)
  end

end
