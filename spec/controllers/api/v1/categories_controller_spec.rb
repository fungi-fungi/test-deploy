require "rails_helper"

RSpec.describe Api::V1::CategoriesController, :type => :controller do

  let(:category) { item.category }
  let(:item) { FactoryGirl.create(:item) }
  
  describe "when logged out" do
    it "access denied" do
      expect(get :show, { id: category.id } ).to have_http_status(:unauthorized)
    end
  end

  describe "when logged in" do

    before(:each) do
      @user = generate_valid_user
      authorize(@user)
      @account = create(:account, sfid: @user[:user_metadata][:sf_id])
    end

    it "access granted" do
      get :show, { id: category.id }
      
      expect(response).to be_success
      expect(response).to have_http_status(:ok)
    end

    describe "#show" do

      it "renders correct json" do
        get :show, { id: category.id }
        expect(JSON.parse(response.body).to_json).to eq(Api::V1::StockItemsSerializer.new(category).to_json)
      end

      it "event is empty" do
        expect(get :show, { id: '' }).to have_http_status(:not_found)
      end

      it "event param is not id" do
        expect(get :show, { id: 'not_a_number' }).to have_http_status(:not_found)
      end

      it "event doesnt exist" do
        expect(get :show, { id: 100000000000 }).to have_http_status(:not_found)
      end

    end

  end

end