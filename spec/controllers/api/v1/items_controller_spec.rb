require "rails_helper"

RSpec.describe Api::V1::ItemsController, :type => :controller do

  let(:item) { FactoryGirl.create(:item) }
  let(:event) { FactoryGirl.create(:event) }

  describe "when logged out" do
    it "access denied" do
      expect(get :show, { id: item.id } ).to have_http_status(:unauthorized)
    end
  end

  describe "when logged in" do

    before(:each) do
      @user = generate_valid_user
      authorize(@user)
      @account = create(:account, sfid: @user[:user_metadata][:sf_id])
    end

    it "access granted" do
      get :show, { id: item.id }
      
      expect(response).to be_success
      expect(response).to have_http_status(:ok)
    end


    describe "#show" do

      it "renders correct json" do
        get :show, { id: item.id }
        expect(JSON.parse(response.body).to_json).to eq(Api::V1::ItemDetailsSerializer.new(item).to_json)
      end

      it "item id is empty" do
        expect(get :show, { id: '' }).to have_http_status(:not_found)
      end

      it "item id is not a number" do
        expect(get :show, { id: 'not_a_number' }).to have_http_status(:not_found)
      end

      it "item doesnt exists" do
        expect(get :show, { id: 100000000000 }).to have_http_status(:not_found)
      end

    end

    describe "#available" do

      let(:available_item_entity) { 
        AvailableItemEntity.new({
          id: item.id,
          name: item.name,
          sfid: item.sfid,
          category: item.category,
          stock_items: [], 
          request_entities: []
        })
      }

      let(:available_item_entity_seriavlized) { Api::V1::AvailableItemEntitySerializer.new(available_item_entity).to_json }

      it "renders correct json" do
        get :available, { id: item.id, event_id: event.id }
        expect(JSON.parse(response.body).to_json).to eq(available_item_entity_seriavlized)
      end

      it "no item" do
        expect(get :available, { id: '', event_id: event.id }).to have_http_status(:not_found)
      end

      it "no event" do
        expect(get :available, { id: item.id }).to have_http_status(:not_found)
      end

    end

  end

end