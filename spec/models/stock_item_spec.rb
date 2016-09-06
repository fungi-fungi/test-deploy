require 'rails_helper'

RSpec.describe StockItem, type: :model do
  
  it "has a valid factory" do
    expect(build(:stock_item)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:stock_item, name: nil)).not_to be_valid
  end

  it "is invalid without sfid" do
    expect(build(:stock_item, sfid: nil)).not_to be_valid
  end

  it "is invalid without a item" do
    expect(build(:stock_item, item: nil)).not_to be_valid
  end

  it "is invalid without account" do
    expect(build(:stock_item, account: nil)).not_to be_valid
  end

  it "is invalid without location" do
    expect(build(:stock_item, i_m__location__c: nil)).not_to be_valid
  end

  it "is invalid without amount" do
    expect(build(:stock_item, i_m__amount__c: nil)).not_to be_valid
  end

  it "is invalid without a create date" do
    expect(build(:item, createddate: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = Item.all.size
    create(:stock_item)
    expect(Item.all.size).to eq(old_size + 1)
  end

  context "available stock" do

    before do

      @total_number_of_items = 30
      @number_of_overlapping_events = 3
      @number_of_non_overlapping_events = 5
      @items_in_first_bom = 10
      @items_in_second_bom = 8

      stock_items = FactoryGirl.create_list(:stock_item, @total_number_of_items)
      items = stock_items.map(&:item)
      
      bom = FactoryGirl.create(:bom_for_exisiting_items_random, existing_items: items, amount_of_items: @items_in_first_bom)
      @request_bom = FactoryGirl.create(:request_bom_for_exisiting_items, existing_items: bom.items)
      @second_request_bom = FactoryGirl.create(:request_bom_for_exisiting_items_random, existing_items: items, amount_of_items: @items_in_second_bom)
      
      FactoryGirl.create(:order_request, event: event, request_bom: @request_bom)
      FactoryGirl.create(:order_request, event: event.overlapping.second, request_bom: @second_request_bom)
      FactoryGirl.create(:configuration_with_sets, bom: bom)
      FactoryGirl.create(:order_request_with_sets, event: non_overlapping.first)
    end

    let(:event) { create(:event_overlap, overlap_amount: @number_of_overlapping_events, non_overlap_amount: @number_of_non_overlapping_events) }
    let(:non_overlapping) { Event.where.not(id: event.overlapping.pluck(:id)) }

    let(:configuration) { Configuration.first }
    let(:order_request_items) { StockItem.get_order_request_items(event) }
    let(:configuration_items) { configuration.get_related_items }
    let(:available_stock) { StockItem.available_stock(configuration, order_request_items) }
    let(:stock_for_configuration) { StockItem.get_stock_for_configuration(event, configuration) }

    

    it "order request map has correct number of items" do
      items_in_order_request = (@request_bom.items.pluck(:sfid) + @second_request_bom.items.pluck(:sfid)).uniq
      expect(order_request_items.size).to be_equal(items_in_order_request.size) 
    end

    it "configuration items map has correct number of items" do
      expect(configuration_items.size).to be_equal(ItemEntity.where(bom: configuration.bom).size)
    end

    it "available stock correct size" do
      expect(available_stock.size).to be_equal(configuration.get_related_items.uniq.size)
    end

    it "available stock correct items" do
      expect(available_stock.map(&:item)).to match_array(configuration.get_related_items.pluck(:sfid).uniq)
    end

    it "available stock has correct amount in each entity" do
      avaliable_stock = StockItem.for_configuration(configuration).group('i_m__stock_item__c.i_m__to_item__c').sum(:i_m__amount__c)
      request_items = StockItem.get_order_request_items(event)
      res = avaliable_stock.map { |item, amount| AvaliableStock.new(item: item, amount: amount - request_items[item]) } 

      expect(stock_for_configuration.map(&:amount)).to match_array(res.map(&:amount))
      expect(stock_for_configuration.map(&:item)).to match_array(res.map(&:item))
    end

  end

end