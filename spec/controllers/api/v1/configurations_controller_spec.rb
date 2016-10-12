require "rails_helper"

RSpec.describe Api::V1::ConfigurationsController, :type => :controller do
  
  describe "when logout" do
    it "respondes with unauthorized" do
      expect(get :index).to have_http_status(:unauthorized)
    end
  end

  describe "when logged in" do
    
    before(:each) do
      @user = generate_valid_user
      authorize(@user)
      @account = create(:account, sfid: @user[:user_metadata][:sf_id])
    end

    describe "#index" do

      it "gets correct response code" do
        get :index        
        expect(response).to be_success
      end

      it 'gets empty array if no configurations' do
        get :index
        expect(JSON.parse(response.body).size).to eq(0)
      end

      it "shows accounts configurations" do
        configurations = FactoryGirl.create_list(:configuration, 10, account: @account)
        get :index
        expect(JSON.parse(response.body).size).to eq(configurations.size)
      end

      context 'pagination' do

        before(:each) do
          @amount_on_second_page = 5
          @configurations = FactoryGirl.create_list(:configuration, WillPaginate.per_page + @amount_on_second_page, account: @account)
        end

        it "returns correct amount of records per page" do
          get :index
          expect(JSON.parse(response.body).size).to eq(WillPaginate.per_page)
        end

        it "return correct records per page in header" do
          get :index
          expect(response.headers['Per-Page'].to_i).to be == WillPaginate.per_page
        end

        it "returns correct total amount in header" do
          get :index
          expect(response.headers['Total'].to_i).to eq(@configurations.size)
        end

        it "returns correct amount of items on all pages" do        
          get :index, { page: 2 }
          expect(JSON.parse(response.body).size).to eq(@amount_on_second_page)
        end

      end

      describe "search" do

        subject { JSON.parse(response.body).size }

        before(:each) do
          @configuration_name = 'Test'
          @amount_of_matching_records = 3
        end

        it 'ignors one symbol name request' do
          get :search, { name:  @configuration_name[0, @configuration_name.length - 3] }
          expect(subject).to eq(0) 
        end
        
        it "no matching records" do
           get :search, { name: 'some other random string' }
           expect(subject).to eq(0)
        end

        it "one matching record" do
          FactoryGirl.create(:configuration, account: @account, name: @configuration_name)
          get :search, { name: @configuration_name }
          expect(subject).to eq(1)
        end

        context "when multiple matching records" do

          before(:each) do
            @amount_of_matching_records.times do |x| 
              FactoryGirl.create(:configuration, account: @account, name: @configuration_name + x.to_s)
            end
          end

          it "lowercase sybols" do
             get :search, { name: @configuration_name.downcase }
             expect(subject).to eq(@amount_of_matching_records)
          end
          
          it "upper case sybols" do
            get :search, { name: @configuration_name.upcase }
            expect(subject).to eq(@amount_of_matching_records)
          end

          it "capitalized sybols" do
            get :search, { name: @configuration_name.capitalize }
            expect(subject).to eq(@amount_of_matching_records)
          end

        end

      end

    end

    describe "#show" do

      let(:configuration) { FactoryGirl.create(:configuration, account: @account) }

      before(:each) do
        Aws::S3::Presigner.any_instance.stub(:presigned_url).and_return("something")
      end

      it "shows the resource" do
        get :show, id: configuration.id
        expect(response.body).to eq(Api::V1::ConfigurationDetailsSerializer.new(configuration).to_json)
      end

      context "category doesnt exists" do
        
        it "raises a not found error" do
          expect(get :show, { id: 11111111111 }).to have_http_status(:not_found)
        end
      end

      context "when different owner" do
        
        it "raises a not found error" do
          expect(get :show, { id: FactoryGirl.create(:configuration).id }).to have_http_status(:not_found)
        end
        
      end

    end

  end

end