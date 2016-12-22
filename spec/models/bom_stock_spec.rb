require 'rails_helper'

RSpec.describe BomStock, type: :model do

  let(:account) { FactoryGirl.create(:account) }
  let(:event) { FactoryGirl.create(:event) }
  let(:bom) { FactoryGirl.create(:bom) }
  let(:request_bom) { FactoryGirl.create(:request_bom) }
  let(:stock_items) { FactoryGirl.create_list(:stock_item, 5, account: account) }
  let(:items) { stock_items.map { |s| s.item } }
  let(:bom_stock) { BomStock.new({ id: bom.id, event: event, bom: bom }) }
  let(:unavailable) { bom_stock.bom_stock_entities.select { |bom_item| bom_item.avaliable_amount < bom_item.item_entity.i_m__amount__c } }
  let(:unavailable_ids) { unavailable.map { |bom_item| bom_item.item_entity.id } }

  it "assignes correct values" do
    FactoryGirl.create(:item_entity, bom: bom, item: items.first, i_m__amount__c: stock_items.first.i_m__amount__c - 1)
    FactoryGirl.create(:item_entity, bom: bom, item: items.second, i_m__amount__c: stock_items.second.i_m__amount__c - 1)
    
    expect(bom_stock.event).to eq(event)
    expect(bom_stock.bom).to eq(bom)
    expect(bom_stock.bom_stock_entities.size).to eq(bom.item_entities.size)
  end

  context "without overlapping order requests" do

    it "no unavailable" do
      FactoryGirl.create(:item_entity, bom: bom, item: items.first, i_m__amount__c: stock_items.first.i_m__amount__c - 1)
      FactoryGirl.create(:item_entity, bom: bom, item: items.second, i_m__amount__c: stock_items.second.i_m__amount__c - 1)

      expect(unavailable.size).to eq(0)
    end

    it "requied more then available" do
      FactoryGirl.create(:item_entity, bom: bom, item: items.first, i_m__amount__c: stock_items.first.i_m__amount__c - 1)
      entity = FactoryGirl.create(:item_entity, bom: bom, item: items.second, i_m__amount__c: stock_items.second.i_m__amount__c + 1)

      expect(unavailable.size).to eq(1)
      expect(unavailable_ids).to include(entity.id)
    end

    it "bom item is not in stock" do
      FactoryGirl.create(:item_entity, bom: bom, item: items.first, i_m__amount__c: stock_items.first.i_m__amount__c - 1)
      FactoryGirl.create(:item_entity, bom: bom, item: items.second, i_m__amount__c: stock_items.second.i_m__amount__c - 1)
      entity = FactoryGirl.create(:item_entity, bom: bom)

      expect(unavailable.size).to eq(1)
      expect(unavailable_ids).to include(entity.id)
    end

    it "bom item not in stock and requied more then available" do
      FactoryGirl.create(:item_entity, bom: bom, item: items.first, i_m__amount__c: stock_items.first.i_m__amount__c - 1)
      entity = FactoryGirl.create(:item_entity, bom: bom, item: items.second, i_m__amount__c: stock_items.second.i_m__amount__c + 1)
      entity_1 = FactoryGirl.create(:item_entity, bom: bom)

      expect(unavailable.size).to eq(2)
      expect(unavailable_ids).to include(entity.id)
      expect(unavailable_ids).to include(entity_1.id)
    end
  end

  context "with overlapping order requests" do

    before(:each) do
      FactoryGirl.create(:order_request, account: account, request_bom: request_bom, event: event)
    end

    it "no unavailable item" do
      FactoryGirl.create(:item_entity, bom: bom, item: items.first, i_m__amount__c: stock_items.first.i_m__amount__c - 1)
      FactoryGirl.create(:item_entity, bom: bom, item: items.second, i_m__amount__c: stock_items.second.i_m__amount__c - 2)
      FactoryGirl.create(:request_entity, request_bom: request_bom, item: items.second, i_m__amount__c: 1)
      
      expect(unavailable.size).to eq(0)
    end

    it "unavailable item" do
      FactoryGirl.create(:item_entity, bom: bom, item: items.first, i_m__amount__c: stock_items.first.i_m__amount__c - 1)
      entity = FactoryGirl.create(:item_entity, bom: bom, item: items.second, i_m__amount__c: stock_items.second.i_m__amount__c - 1)
      FactoryGirl.create(:request_entity, request_bom: request_bom, item: items.second, i_m__amount__c: stock_items.second.i_m__amount__c)

      expect(unavailable.size).to eq(1)
      expect(unavailable_ids).to include(entity.id)
    end

    it "two unavailable items" do
      entity = FactoryGirl.create(:item_entity, bom: bom, item: items.first, i_m__amount__c: stock_items.first.i_m__amount__c - 1)
      entity_1 = FactoryGirl.create(:item_entity, bom: bom, item: items.second, i_m__amount__c: stock_items.second.i_m__amount__c - 1)
      FactoryGirl.create(:request_entity, request_bom: request_bom, item: items.first, i_m__amount__c: stock_items.first.i_m__amount__c)
      FactoryGirl.create(:request_entity, request_bom: request_bom, item: items.second, i_m__amount__c: stock_items.second.i_m__amount__c)

      expect(unavailable.size).to eq(2)
      expect(unavailable_ids).to include(entity.id)
      expect(unavailable_ids).to include(entity_1.id)
    end

  end

  
end