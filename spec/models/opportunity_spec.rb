require 'rails_helper'

RSpec.describe Opportunity, type: :model do
  
  it "has a valid factory" do
    expect(build(:opportunity)).to be_valid
  end

  it "is invalid without name" do
    expect(build(:opportunity, name: nil)).not_to be_valid
  end

  it "is invalid without sfid" do
    expect(build(:opportunity, sfid: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = Opportunity.all.size
    create(:opportunity)
    expect(Opportunity.all.size).to eq(old_size + 1)
  end

  describe "overlapping" do

    before do
      @overlap_amount = 1
      @non_overlap_amount = 3

      FactoryGirl.create(:opportunities_with_overlap,
        overlap_amount: @overlap_amount,
        non_overlap_amount: @non_overlap_amount,
        start_date: event.i_m__start_date__c,
        end_date: event.i_m__end_date__c
      )
    end
    
    let(:event) { FactoryGirl.create(:event) }


    it 'corectly caluclated' do
      expect(Opportunity.overlapping(event).count).to be_equal(@overlap_amount * 4)
    end

  end

end