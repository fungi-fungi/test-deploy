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
    ITEMS_IN_FIRST = 15
    ITMS_IN_SECOND = 3
    let(:event) { FactoryGirl.create(:event_overlap, overlap_amount: 1, non_overlap_amount: 3) }
    let(:non_overlapping) { Event.where.not(id: event.overlapping.pluck(:id)) }
    
    let(:order_request) { FactoryGirl.create(:order_request, event: event) }
    let(:second_order_request) { FactoryGirl.create(:order_request, event: event.overlapping.second) }

    before do
      FactoryGirl.create(:order_request_with_sets, event: non_overlapping.first)
      FactoryGirl.create_list(:request_entity, ITEMS_IN_FIRST, request_bom: order_request.request_bom)
      FactoryGirl.create_list(:request_entity, ITMS_IN_SECOND, request_bom: second_order_request.request_bom)
    end

    it "items for order request" do
      expect(order_request.get_related_items.count).to be_equal(ITEMS_IN_FIRST)
    end

    it "entities for single sfid" do
      expect(OrderRequest.get_related_entities(order_request.sfid).count).to be_equal(ITEMS_IN_FIRST)
    end

    it "entities for array of sfids" do
      sfids = [order_request.sfid, second_order_request.sfid]
      expect(OrderRequest.get_related_entities(sfids).count).to be_equal(ITEMS_IN_FIRST + ITMS_IN_SECOND)
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