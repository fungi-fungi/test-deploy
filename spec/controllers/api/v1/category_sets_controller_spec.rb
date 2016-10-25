require "rails_helper"

RSpec.describe Api::V1::CategorySetsController, :type => :controller do

  let(:category_set) { FactoryGirl.create(:category_set_with_entities) }

  describe "when logged out" do
    it "access denied" do
      expect(get :show, { id: category_set.id } ).to have_http_status(:unauthorized)
    end
  end

  describe "when logged in" do

    before(:each) do
      @user = generate_valid_user
      authorize(@user)
      @account = create(:account, sfid: @user[:user_metadata][:sf_id])
    end

    it "access granted" do
      get :show, { id: category_set.id }
      
      expect(response).to be_success
      expect(response).to have_http_status(:ok)

    end


    describe "#show" do

      it "renders correct json" do
        get :show, { id: category_set.id }
        expect(JSON.parse(response.body).to_json).to eq(Api::V1::CategorySetSerializer.new(category_set).to_json)
      end

      it "category_set is empty" do
        expect(get :show, { id: '' }).to have_http_status(:not_found)
      end

      it "category_set param is not id" do
        expect(get :show, { id: 'not_a_number' }).to have_http_status(:not_found)
      end

      it "category_set doesnt exist" do
        expect(get :show, { id: 100000000000 }).to have_http_status(:not_found)
      end

    end

    describe "#stock" do

      # it "no bom" do
      #   expect(get :stock, { id: '' }).to have_http_status(:not_found)
      # end

      # it "no event" do
      #   expect(get :stock, { id: bom.id }).to have_http_status(:not_found)
      # end

      # it "event is not valid" do
      #   expect(get :stock, { id: bom.id, event_id: '' }).to have_http_status(:not_found)
      # end

      # it "event id doesnt exist" do
      #   expect(get :stock, { id: bom.id, event_id: 1 }).to have_http_status(:not_found)
      # end

      # describe "renders serialized" do

      #   before(:each) do
      #     get :stock, { id: bom.id, event_id: event.id }
      #   end

      #   it "bom" do
      #     serialized_bom = Api::V1::BomSimpleSerializer.new(bom).to_json
      #     expect((JSON.parse(response.body)['bom']).to_json).to eq(serialized_bom)
      #   end

      #   it "bom entities" do
      #     expect((JSON.parse(response.body)['entities']).size).to eq(bom.items.size)
      #   end

      #   it "bom entity" do
      #     bom_stock = BomStock.new({ id: bom.id, event: event, bom: bom })
      #     serialized_item = Api::V1::BomStockEntitySerializer.new(bom_stock.bom_stock_entities.first).to_json
      #     expect((JSON.parse(response.body)['entities']).first.to_json).to eq(serialized_item)
      #   end

      # end

    end

  end

end