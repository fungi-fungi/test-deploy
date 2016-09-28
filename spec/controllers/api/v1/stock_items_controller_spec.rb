require "rails_helper"

RSpec.describe Api::V1::StockItemsController, :type => :controller do
  
  describe "when logged out" do
    it "access denied" do
      expect(get :index).to have_http_status(401)
    end
  end

  describe "when logged in" do
    
    before(:each) do
      @user = generate_valid_user
      authorize(@user)
      @account = create(:account, sfid: @user[:user_metadata][:sf_id])
    end

    it "access granted" do
      get :index
      
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    describe "#index" do 

      it "stok is empty" do
        get :index
        expect(JSON.parse(response.body).size).to eq(0)
      end

      it "account stock" do
        get :index
        expect(JSON.parse(response.body).size).to eq(@account.stock_items.size)
      end

      it_behaves_like "a paginable", :stock_item_belongs_to_iurii
      
    end

    describe "#show" do

      let(:stock_item) { FactoryGirl.create(:stock_item_belongs_to_iurii) }

      it "renders correct json" do
        get :show, { id: stock_item.id }
        expect(JSON.parse(response.body).to_json).to eq(Api::V1::StockItemSerializer.new(stock_item).to_json)
      end

      it "is empty" do
        expect(get :show, { id: '' }).to have_http_status(:not_found)
      end

      it "param is not id" do
        expect(get :show, { id: 'not_a_number' }).to have_http_status(:not_found)
      end

      it "doesnt exist" do
        expect(get :show, { id: 100000000000 }).to have_http_status(:not_found)
      end

    end

  end

end