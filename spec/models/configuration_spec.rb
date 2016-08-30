require 'rails_helper'

RSpec.describe Configuration, type: :model do
  
  it "has a valid factory" do
    expect(build(:configuration)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:configuration, name: nil)).not_to be_valid
  end

  it "is invalid without sfid" do
    expect(build(:configuration, sfid: nil)).not_to be_valid
  end

  it "is invalid without account" do
    expect(build(:configuration, account: nil)).not_to be_valid
  end

  it "is invalid without bom" do
    expect(build(:configuration, bom: nil)).not_to be_valid
  end

  it "is invalid without category set" do
    expect(build(:configuration, category_set: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = Configuration.all.size
    create(:configuration)
    expect(Configuration.all.size).to eq(old_size + 1)
  end

  context 'model returns' do
    NUMBER_OF_ITEMS = 15
    let(:configuration) { FactoryGirl.create(:configuration) }

    before do
      FactoryGirl.create(:configuration_with_sets)
      FactoryGirl.create_list(:item_entity, NUMBER_OF_ITEMS, bom: configuration.bom)
    end

    it "correct number of related items" do
      expect(configuration.get_related_items.count).to be_equal(NUMBER_OF_ITEMS)
    end

    it "correct related items" do
      expect(configuration.get_related_items.pluck(:sfid)).to match_array(ItemEntity.where(bom: configuration.bom).pluck(:i_m__to_item__c))
    end

    it "correct number of related entities" do
      expect(configuration.get_related_entities.count).to be_equal(NUMBER_OF_ITEMS)
    end

    it "correct related entities" do
      expect(configuration.get_related_entities.pluck(:sfid)).to match_array(ItemEntity.where(bom: configuration.bom).pluck(:sfid))
    end
  end

end