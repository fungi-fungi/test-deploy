require 'rails_helper'

RSpec.describe OrderRequest, type: :model do
  
  it "has a valid factory" do
    expect(build(:order_request)).to be_valid
  end

 it "is invalid without a associated account" do
    expect(build(:order_request, account: nil)).not_to be_valid
  end

   it "is invalid without request bom" do
    expect(build(:order_request, request_bom: nil)).not_to be_valid
  end

  it "is invalid without a event" do
    expect(build(:order_request, event: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = OrderRequest.all.size
    create(:order_request)
    expect(OrderRequest.all.size).to eq(old_size + 1)
  end

  context "model returns all" do

    before do
      @items_in_first = 15
      @items_in_second = 3
      @overlap_amount = 1
      @non_overlap_amount = 3

      FactoryGirl.create(:order_request_with_sets, event: non_overlapping.first)
      FactoryGirl.create_list(:request_entity, @items_in_first, request_bom: order_request.request_bom)
      FactoryGirl.create_list(:request_entity, @items_in_second, request_bom: second_order_request.request_bom)
    end
    
    let(:event) { FactoryGirl.create(:event_overlap, overlap_amount: @overlap_amount, non_overlap_amount: @non_overlap_amount) }
    let(:non_overlapping) { Event.where.not(id: event.overlapping.pluck(:id)) }
    
    let(:order_request) { FactoryGirl.create(:order_request, event: event) }
    let(:second_order_request) { FactoryGirl.create(:order_request, event: event.overlapping.second) }
    let(:orders_sfids) { [order_request.sfid, second_order_request.sfid] }

    it "items for order request" do
      expect(order_request.get_related_items.count).to be_equal(@items_in_first)
    end

    it "entities for single sfid" do
      expect(OrderRequest.get_related_entities(order_request.sfid).count).to be_equal(@items_in_first)
    end

    it "entities for array of sfids" do
      expect(OrderRequest.get_related_entities(orders_sfids).count).to be_equal(@items_in_first + @items_in_second)
    end

    it "entities for empty object" do
      expect(OrderRequest.get_related_entities(nil).count).to be_equal(0)
      expect(OrderRequest.get_related_entities([]).count).to be_equal(0)
    end

    it "order request for oveplaped events" do
      expect(OrderRequest.belongs_to_overlap(event).size).to be_equal(2)
    end

  end

end