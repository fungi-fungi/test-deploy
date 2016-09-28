require "rails_helper"

RSpec.describe Api::V1::EventsController, :type => :controller do
  
  describe "when logged out" do
    it "access denied" do
      expect(get :index).to have_http_status(:unauthorized)
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
      expect(response).to have_http_status(:ok)
    end


    describe "#index" do

      it "shows all events" do
        get :index
        expect(response.headers['Total'].to_i).to eq(Event.all.size)
      end

      it "renders correct json" do
        event = FactoryGirl.create(:event)
        get :index
        expect(JSON.parse(response.body)[0].to_json).to eq(Api::V1::EventSerializer.new(event).to_json)
      end

      context "search" do

        subject { JSON.parse(response.body).size }

        before(:each) do
          @event_name = 'Test'
          @amount_of_matching_records = 3
        end

        it "ignors one symbol name request" do
          get :search, { name:  @event_name[0, @event_name.length - 3] }
          expect(subject).to eq(0) 
        end
        
        it "no matching records" do
           get :search, { name: 'some other random string' }
           expect(subject).to eq(0)
        end

        it "one matching record" do
          FactoryGirl.create(:event, name: @event_name)
          get :search, { name: @event_name }
          expect(subject).to eq(1)
        end

        context "when multiple matching records" do

          before(:each) do
            @amount_of_matching_records.times do |x| 
              FactoryGirl.create(:event, name: @event_name + x.to_s)
            end
          end

          it "lowercase sybols" do
             get :search, { name: @event_name.downcase }
             expect(subject).to eq(@amount_of_matching_records)
          end
          
          it "upper case sybols" do
            get :search, { name: @event_name.upcase }
            expect(subject).to eq(@amount_of_matching_records)
          end

          it "capitalized sybols" do
            get :search, { name: @event_name.capitalize }
            expect(subject).to eq(@amount_of_matching_records)
          end

        end

      end

      it_behaves_like "a paginable", :event
    end

    describe "#show" do

      let(:event) { FactoryGirl.create(:event) }

      it "renders correct json" do
        get :show, { id: event.id }
        expect(JSON.parse(response.body).to_json).to eq(Api::V1::EventSerializer.new(event).to_json)
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