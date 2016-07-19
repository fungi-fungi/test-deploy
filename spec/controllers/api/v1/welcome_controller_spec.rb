require "rails_helper"

RSpec.describe Api::V1::WelcomeController, :type => :controller do
  
  
  # describe "GET #index" do
  #   it "responds successfully with an HTTP 200 status code" do
  #     get :index
      
  #     expect(response).to be_success
  #     expect(response).to have_http_status(200)
  #   end

  #   it "renders correct json" do
  #     get :index
  #     expect(response.body).to eq([{msg: "Hello world"}, {msg: "Something else"}].to_json)
  #   end
  # end

  describe "Unauthorized request" do
    it "respondes with 401" do
      expect(get :index).to have_http_status(401)
    end
  end

  describe "Authorize request" do
    before(:each) do
      @user = generate_valid_user
      authorize(@user)
    end

    it "gets correct response code" do
      get :index
      
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end