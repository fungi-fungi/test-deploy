 require "rails_helper"

RSpec.describe Api::V1::BomsController, :type => :controller do

  let(:stock_items) { FactoryGirl.create_list(:stock_item, 10) }
  let(:items) { stock_items.map { |stock_item| stock_item.item } }
  let(:bom) { FactoryGirl.create(:bom_for_exisiting_items_random, existing_items: items, amount_of_items: 5) }
  let(:event) { FactoryGirl.create(:event) }

  describe "when logged out" do
    it "access denied" do
      expect(get :show, { id: bom.id } ).to have_http_status(:unauthorized)
    end
  end

  describe "when logged in" do

    before(:each) do
      @user = generate_valid_user
      authorize(@user)
      @account = create(:account, sfid: @user[:user_metadata][:sf_id])
    end

    it "access granted" do
      get :show, { id: bom.id }
      
      expect(response).to be_success
      expect(response).to have_http_status(:ok)
    end


    describe "#show" do

      it "renders correct json" do
        get :show, { id: bom.id }
        expect(JSON.parse(response.body).to_json).to eq(Api::V1::BomSerializer.new(bom).to_json)
      end

      it "bom is empty" do
        expect(get :show, { id: '' }).to have_http_status(:not_found)
      end

      it "bom param is not id" do
        expect(get :show, { id: 'not_a_number' }).to have_http_status(:not_found)
      end

      it "bom doesnt exist" do
        expect(get :show, { id: 100000000000 }).to have_http_status(:not_found)
      end

    end

    describe "#stock" do

      it "no bom" do
        expect(get :stock, { id: '' }).to have_http_status(:not_found)
      end

      it "no event" do
        expect(get :stock, { id: bom.id }).to have_http_status(:not_found)
      end

      it "event is not valid" do
        expect(get :stock, { id: bom.id, event_id: '' }).to have_http_status(:not_found)
      end

      it "event id doesnt exist" do
        expect(get :stock, { id: bom.id, event_id: 1 }).to have_http_status(:not_found)
      end

      describe "renders serialized" do

        before(:each) do
          get :stock, { id: bom.id, event_id: event.id }
        end

        it "bom" do
          serialized_bom = Api::V1::BomSimpleSerializer.new(bom).to_json
          expect((JSON.parse(response.body)['bom']).to_json).to eq(serialized_bom)
        end

        it "bom entities" do
          expect((JSON.parse(response.body)['entities']).size).to eq(bom.items.size)
        end

        it "bom entity" do
          bom_stock = BomStock.new({ id: bom.id, event: event, bom: bom })
          serialized_item = Api::V1::BomStockEntitySerializer.new(bom_stock.bom_stock_entities.first).to_json
          expect((JSON.parse(response.body)['entities']).first.to_json).to eq(serialized_item)
        end

      end

    end

  end

end