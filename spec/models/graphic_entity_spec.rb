require 'rails_helper'

RSpec.describe GraphicEntity, type: :model do

  it "has a valid factory" do
    expect(build(:graphic_entity)).to be_valid
  end

  it "is invalid without a item" do
    expect(build(:graphic_entity, item: nil)).not_to be_valid
  end

  it "is invalid without a graphic set" do
    expect(build(:graphic_entity, graphics_set: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = GraphicEntity.all.size
    create(:graphic_entity)
    expect(GraphicEntity.all.size).to eq(old_size + 1)
  end
  
end