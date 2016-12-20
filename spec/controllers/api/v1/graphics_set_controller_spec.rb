require "rails_helper"

RSpec.describe Api::V1::GraphicsSetController, :type => :controller do

  let(:item) { FactoryGirl.create(:item) }
  let(:configuration) { FactoryGirl.create(:configuration, account: @account) }
  let(:graphics_set) { FactoryGirl.create(:graphics_set, configuration: configuration) }
  let(:random_configuration) { FactoryGirl.create(:configuration) }
  let(:random_graphics_set) { FactoryGirl.create(:graphics_set) }
  let(:graphic_entities) { FactoryGirl.create_list(:graphic_entity, @amount_of_entities, graphics_set: graphics_set) }

  describe "when logged out" do
    it "access denied" do
      configuration = FactoryGirl.create(:configuration)
      expect(get :show, { id: item.id, configuration_id: configuration.id } ).to have_http_status(:unauthorized)
    end
  end

  describe "when logged in" do

    before(:each) do
      @user = generate_valid_user
      authorize(@user)
      @account = create(:account, sfid: @user[:user_metadata][:sf_id])
    end

    it "access granted" do
      get :index, { configuration_id: configuration.id }
      
      expect(response).to be_success
      expect(response).to have_http_status(:ok)
    end

    describe "#index" do

      subject { JSON.parse(response.body)['graphics_sets'].size }
       
      context "no graphics sets for configuration" do
        
        it "correct size" do
          get :index, { configuration_id: configuration.id }
          expect(subject).to eq(0)
        end

      end

      context "multiple graphics sets for configuration" do

        before(:each) do
          @amount_of_sets = 10
          @graphics_sets = create_list(:graphics_set, @amount_of_sets, configuration: configuration)
        end

        it "correct size" do
          get :index, { configuration_id: configuration.id }
          expect(subject).to eq(@amount_of_sets)
        end

        it "every set serialized" do
          get :index, { configuration_id: configuration.id }
          expect(response.body).to eq(Api::V1::ConfigurationWithGraphicsSetsSerializer.new(configuration).to_json)
        end

      end
    end

    describe "#show" do

      it "correct response" do
        expect(get :show, { id: graphics_set.id, configuration_id: configuration.id }).to have_http_status(:ok)
      end
      
      it "renders correctly" do
        get :show, { id: graphics_set.id, configuration_id: configuration.id }
        expect(response.body).to eq(Api::V1::GraphicsSetWithEntitiesSerializer.new(graphics_set).to_json)
      end

      it "no such set id" do
        expect(get :show, { id: 1, configuration_id: configuration.id }).to have_http_status(:not_found)
      end

      it "set doesnt belong to user" do
        expect(get :show, { id: 1, configuration_id: random_configuration.id }).to have_http_status(:not_found)
      end

      it "set id is not a valid value" do
        expect(get :show, { id: 'not_a_number', configuration_id: random_configuration.id }).to have_http_status(:not_found)
      end

      it "set doesnt belong to configuration" do
        expect(get :show, { id: random_graphics_set.id, configuration_id: configuration.id }).to have_http_status(:not_found)
      end

       describe "#graphics" do

        before(:each) do
          @amount_of_entities = 10
        end
      
        it "correct status" do
          expect(get :graphics, { id: graphics_set.id, configuration_id: configuration.id }).to have_http_status(:ok)
        end

        it "all entities are serialized" do
          get :graphics, { id: graphic_entities.first.graphics_set.id, configuration_id: configuration.id }
          expect(response.body).to eq(Api::V1::GraphicsSetWithEntitiesSerializer.new(graphics_set).to_json)
        end

        it "renders correct ammount" do
          get :graphics, { id: graphic_entities.first.graphics_set.id, configuration_id: configuration.id }
          expect(JSON.parse(response.body)['graphic_entities'].size).to eq(@amount_of_entities)
        end

      end

    end

  end
end