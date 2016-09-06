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
          create_list(:stock_item,  WillPaginate.per_page + 12, account: @account)
        end

        it "returns correct amount of recorde per page" do
          get :index
          expect(JSON.parse(response.body).size).to eq(WillPaginate.per_page)
          expect(response.headers['Per-Page'].to_i).to be == WillPaginate.per_page
        end

        it "returns correct total amount in header" do
          get :index
          expect(response.headers['Total'].to_i).to eq(@account.stock_items.size)
        end

        it "returns correct amount of items on next page" do
          get :index, {page: '2'}
          expect(JSON.parse(response.body).size).to eq(@account.stock_items.size - WillPaginate.per_page)
        end

      end

    end

    describe "stock availability" do

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
        FactoryGirl.create(:configuration_with_sets, bom: bom, account: @account)
        FactoryGirl.create(:configuration_with_sets, bom: bom)
        FactoryGirl.create(:order_request_with_sets, event: non_overlapping.first)
      end

      let(:event) { create(:event_overlap, overlap_amount: @number_of_overlapping_events, non_overlap_amount: @number_of_non_overlapping_events) }
      let(:non_overlapping) { Event.where.not(id: event.overlapping.pluck(:id)) }
      let(:configuration) { Configuration.first }
      let(:configuration_not_iurii) { Configuration.second } 
      
      it "return success" do
        get :available, { configuration_id: configuration.sfid, event_id: event.sfid }
        
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "show error if configuration param is not valide" do
        get :available, { configuration_id: nil, event_id: event.sfid } 
        expect(response).to have_http_status(400)
      end

      it "show error if event param is not valide" do
         get :available, { configuration_id: configuration.sfid, event_id: nil } 
         expect(response).to have_http_status(400)
      end

      it "show error if configuration doesn't belong to authorized user" do
        get :available, { configuration_id: configuration_not_iurii.sfid, event_id: event.sfid }
        expect(response).to have_http_status(400)
      end

    end

  end

end