require 'rails_helper'

RSpec.describe ItemEntity, type: :model do
  
  it "has a valid factory" do
    expect(build(:item_entity)).to be_valid
  end

  it "is invalid without a sfid" do
    expect(build(:item_entity, sfid: nil)).not_to be_valid
  end

  it "is invalid without a name" do
    expect(build(:item_entity, name: nil)).not_to be_valid
  end

  it "is invalid without a ammount" do
    expect(build(:item_entity, i_m__amount__c: nil)).not_to be_valid
  end

  it "is invalid without a associated item" do
    expect(build(:item_entity, item: nil)).not_to be_valid
  end

  it "is invalid without a associated bom" do
    expect(build(:item_entity, bom: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = ItemEntity.all.size
    create(:item_entity)
    expect(ItemEntity.all.size).to eq(old_size + 1)
  end

  context "map transformation" do
    
    before do
      @number_of_entities = 10
      create_list(:item_entities_with_duplicates, @number_of_entities)
    end

    let(:entities) { ItemEntity.all }
    let(:result_map) { ItemEntity.build_item_id_map(entities) }   
    
    it "test data is not empty" do
      expect(result_map.size).not_to be_equal(0)
      expect(Item.all.size).not_to be_equal(0)
      expect(entities.size).not_to be_equal(0)
      expect(entities.size).not_to be_equal(@number_of_entities)
    end
  
    it "has correct number of elements" do
      expect(result_map.size).to be_equal(@number_of_entities)
    end

    it "has correct keys in hash" do
      expect(result_map.keys).to match_array(Item.pluck(:sfid))
    end

    it "has correct values in hash" do
      expect(result_map.values).not_to match_array(entities.pluck(:i_m__amount__c))
    end

    it "has correct values in hash" do

      res = entities.select(:i_m__to_item__c, :i_m__amount__c).group(:i_m__to_item__c).sum(:i_m__amount__c)

      expect(result_map.values).to match_array(res.values)
    end

  end

end
