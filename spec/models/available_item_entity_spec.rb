require 'rails_helper'

RSpec.describe AvailableItemEntity, type: :model do

  let(:item) { FactoryGirl.create(:item) }
  let(:stock_items) { FactoryGirl.create_list(:stock_item, @amount_of_stock_items, item: item, i_m__amount__c: @amount_for_stock) }
  let(:request_entities) { FactoryGirl.create_list(:request_entity, @amout_of_request_entities, item: item, i_m__amount__c: @amount_for_request_entities) }
  
  let(:available_item_entity) { 
    available_item_entity = AvailableItemEntity.new({
       id: item.id,
       name: item.name,
       sfid: item.sfid,
       category: item.category,
       stock_items: stock_items, 
       request_entities: request_entities
    })
   }

  context "more in stock then reserved" do

    before(:each) do
      @amount_for_stock = 20
      @amount_for_request_entities = 10
      @amount_of_stock_items = @amout_of_request_entities = 2
    end

    it "assignes correct values" do
      expect(available_item_entity.id).to eq(item.id)
      expect(available_item_entity.name).to eq(item.name)
      expect(available_item_entity.sfid).to eq(item.sfid)
      expect(available_item_entity.category).to eq(item.category)
      expect(available_item_entity.stock_items).to eq(stock_items)
      expect(available_item_entity.request_entities).to eq(request_entities)
    end

    it "calculations correct" do
      expect(available_item_entity.total_in_stock).to eq(@amount_of_stock_items * @amount_for_stock)
      expect(available_item_entity.total_reserved).to eq(@amout_of_request_entities * @amount_for_request_entities)
      expect(available_item_entity.total_avaliable).to be > 0
      expect(available_item_entity.total_avaliable).to eq(@amount_of_stock_items * @amount_for_stock - @amout_of_request_entities * @amount_for_request_entities)
    end

  end

  context "less in stock then reserved" do

    before(:each) do
      @amount_for_stock = 10
      @amount_for_request_entities = 20
      @amount_of_stock_items = @amout_of_request_entities = 2
    end

    it "calculations correct" do
      expect(available_item_entity.total_in_stock).to eq(@amount_of_stock_items * @amount_for_stock)
      expect(available_item_entity.total_reserved).to eq(@amout_of_request_entities * @amount_for_request_entities)
      expect(available_item_entity.total_avaliable).to eq(0)
    end
  
  end

  context "no reserved" do

    before(:each) do
      @amount_for_stock = 10
      @amount_for_request_entities = 20
      @amount_of_stock_items = 2
      @amout_of_request_entities = 0
    end

    it "calculations correct" do
      expect(available_item_entity.total_in_stock).to eq(@amount_of_stock_items * @amount_for_stock)
      expect(available_item_entity.total_reserved).to eq(0)
      expect(available_item_entity.total_avaliable).to be > 0
      expect(available_item_entity.total_avaliable).to eq(@amount_of_stock_items * @amount_for_stock)
    end
  
  end

  context "no in stock" do

    before(:each) do
      @amount_for_stock = 10
      @amount_for_request_entities = 20
      @amount_of_stock_items = 0
      @amout_of_request_entities = 2
    end

    it "calculations correct" do
      expect(available_item_entity.total_reserved).to eq(@amout_of_request_entities * @amount_for_request_entities)
      expect(available_item_entity.total_in_stock).to eq(0)
      expect(available_item_entity.total_avaliable).to eq(0)
    end
  
  end

end