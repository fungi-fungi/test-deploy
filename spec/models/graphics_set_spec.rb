require 'rails_helper'

RSpec.describe GraphicsSet, type: :model do

  it "has a valid factory" do
    expect(build(:graphics_set)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:graphics_set, name: nil)).not_to be_valid
  end

  it "is invalid without a configuration" do
    expect(build(:graphics_set, configuration: nil)).not_to be_valid
  end
  
  it "can be saved" do
    old_size = GraphicsSet.all.size
    create(:graphics_set)
    expect(GraphicsSet.all.size).to eq(old_size + 1)
  end

end