require "rails_helper"

RSpec.describe Api::V1::StockItemsController, :type => :controller do
  
  describe "Unauthorized request" do
    it "respondes with 401" do
      expect(get :index).to have_http_status(401)
    end
  end

  describe "Authorized request" do
    before(:each) do
      @user = generate_valid_user
      authorize(@user)
      @account = create(:account, sfid: @user[:user_metadata][:sf_id])
    end

    it "gets correct response code" do
      get :index
      
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'gets empty array if stok is empty' do
      get :index
      expect(JSON.parse(response.body).size).to eq(0)
    end

    describe "to REST" do

      before(:each) do
        @other_account = create(:account)
        create_list(:stock_item, 10, account: @account)
        create_list(:stock_item, 3, account: @other_account)
      end

      it "returns account stock" do
        get :index
        expect(JSON.parse(response.body).size).to eq(@account.stock_items.size)
      end

      it 'return stock for logged in user' do
        get :index
        expect(JSON.parse(response.body).size).to eq(@account.stock_items.size)
      end

      describe 'pagination' do

        before(:each) do
          create_list(:stock_item, 50, account: @account)
        end

        it "returns correct amount of recorde per page" do
          get :index
          expect(JSON.parse(response.body).size).to eq(Kaminari.config.default_per_page)
          expect(response.headers['Per-Page'].to_i).to be == Kaminari.config.default_per_page
        end

        it "returns correct total amount in header" do
          get :index
          expect(response.headers['Total'].to_i).to eq(@account.stock_items.size)
        end

        it "returns correct amount of items on next page" do
          get :index, {page: '2'}
          expect(JSON.parse(response.body).size).to eq(@account.stock_items.size - Kaminari.config.default_per_page)
        end

      end

    end

  end

end