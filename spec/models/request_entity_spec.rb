require 'rails_helper'

RSpec.describe RequestEntity, type: :model do
  
  it "has a valid factory" do
    expect(build(:request_entity)).to be_valid
  end

  it "is invalid without name" do
    expect(build(:request_entity, name: nil)).not_to be_valid
  end

  it "is invalid without amount" do
    expect(build(:request_entity, i_m__amount__c: nil)).not_to be_valid
  end

  it "is invalid if amount less then 0" do
    expect(build(:request_entity, i_m__amount__c: -1)).not_to be_valid
  end

  it "is invalid if amount is 0" do
    expect(build(:request_entity, i_m__amount__c: 0)).not_to be_valid
  end

  it "is invalid if no item specified" do
    expect(build(:request_entity, item: nil)).not_to be_valid
  end

  it "is invalid if no request bom specified" do
    expect(build(:request_entity, request_bom: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = RequestEntity.all.size
    create(:request_entity)
    expect(RequestEntity.all.size).to eq(old_size + 1)
  end

  context "map transformation" do
    Number_OF_ENTITIES = 10
    let(:result_map) { RequestEntity.build_item_id_map(data) }
    let(:data) { create_list(:request_entity, Number_OF_ENTITIES) }
    
    it "test data is not empty" do
      expect(result_map.size).not_to be_equal(0)
      expect(Item.all.size).not_to be_equal(0)
      expect(RequestEntity.all.size).not_to be_equal(0)
    end
  
    it "has correct number of elements" do
      expect(result_map.size).to be_equal(Number_OF_ENTITIES)
    end

    it "has correct keys in hash" do
      expect(result_map.keys).to match_array(Item.pluck(:sfid))
    end

    it "has correct values in hash" do
      expect(result_map.values).to match_array(RequestEntity.all)
    end

  end
end