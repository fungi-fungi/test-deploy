require "rails_helper"

RSpec.describe Api::V1::OrderRequestsController, :type => :controller do
  
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

    it 'gets empty array if there is no order requests' do
      get :index
      expect(JSON.parse(response.body).size).to eq(0)
    end

    describe "to REST" do

      before(:each) do
        create_list(:order_request, WillPaginate.per_page, account: @account)
      end

      it "returns order requests" do
        get :index
        expect(JSON.parse(response.body).size).to eq(OrderRequest.all.size)
      end

      describe 'pagination' do

        before(:each) do
          create_list(:order_request,  WillPaginate.per_page - 1, account: @account)
        end

        it "returns correct amount of recorde per page" do
          get :index
          expect(JSON.parse(response.body).size).to eq(WillPaginate.per_page)
          expect(response.headers['Per-Page'].to_i).to be == WillPaginate.per_page
        end

        it "returns correct total amount in header" do
          get :index
          expect(response.headers['Total'].to_i).to eq(OrderRequest.all.size)
        end

        it "returns correct amount of items on next page" do
          get :index, {page: '2'}
          expect(JSON.parse(response.body).size).to eq(OrderRequest.all.size - WillPaginate.per_page)
        end

      end

      describe '#create' do

        let(:event) { FactoryGirl.create(:event) }
        let(:created_entities) { FactoryGirl.create_list(:item_entity, 10) }
        let(:entities) { created_entities.map { |entity| {item: entity.item.sfid, amount: entity.i_m__amount__c} } }
        let(:new_order_request) { OrderRequest.last }
        let(:new_request_bom) { RequestBom.last }
        let(:order_date) { {order: {entities: entities, event: event.sfid}} }
      
        it "when request is empty" do
          post :create, {}
          expect(response).to have_http_status(:bad_request)
        end

        it "when entities is nil" do
          post :create, {order: {event: event.sfid, entities: nil}}
          expect(response).to have_http_status(:bad_request)
        end

        it "when request has no items" do
          post :create, {order: {event: event.sfid}}
          expect(response).to have_http_status(:bad_request)
        end

        it "when request has no event" do
          post :create, {order: {entities: entities}}
          expect(response).to have_http_status(:bad_request)
        end

        it "when event is not valid" do
          post :create, {order: {entities: entities, event: ""}}
          expect(response).to have_http_status(:bad_request)
        end

        it "when event is nil" do
          post :create, {order: {entities: entities, event: nil}}
          expect(response).to have_http_status(:bad_request)
        end
        
        it "when list of entities is empty" do
          post :create, {order: {entities: [], event: event.sfid}}
          expect(response).to have_http_status(:bad_request)
        end

        it "returns correct code" do
          post :create, order_date
          expect(response).to have_http_status(:created)
        end

        it "returns new request order" do
          post :create, order_date
          expect(response.body).to eq(Api::V1::OrderRequestSerializer.new(new_order_request).to_json)
        end

        it "creates a new order request" do
          number_of_order_request = OrderRequest.all.size
          post :create, order_date
          expect(OrderRequest.all.size).to eq(number_of_order_request + 1)
        end
        
        it "creates a new request bom" do
          number_of_request_boms = RequestBom.all.size
          post :create, order_date
          expect(RequestBom.all.size).to eq(number_of_request_boms + 1)
        end

        it "creates request entity for each item" do
          number_of_request_entities = RequestEntity.all.size
          post :create, order_date
          expect(RequestEntity.all.size).to eq(number_of_request_entities + entities.size)
        end

        it "new order request has correct bom" do
          post :create, order_date
          expect(new_order_request.request_bom).to eq(new_request_bom)
        end

        it "new order request has correct event" do
          post :create, order_date
          expect(new_order_request.event).to eq(event)
        end

        it "new request bom has correct amount of entities" do
          post :create, order_date
          expect(new_request_bom.request_entities.size).to eq(entities.size)
        end

      end

    end

  end

end