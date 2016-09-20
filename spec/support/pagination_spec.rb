RSpec.shared_examples "a paginable" do |object_factory|
  
  context "response returns" do

    before(:each) do
      @amount_on_second_page = 5
      @objects = FactoryGirl.create_list(object_factory, WillPaginate.per_page + @amount_on_second_page)
    end
    
    it "correct amount of records" do
      get :index
      expect(JSON.parse(response.body).size).to eq(WillPaginate.per_page)
    end

    it "correct records per page in header" do
      get :index
      expect(response.headers['Per-Page'].to_i).to be == WillPaginate.per_page
    end

    it "correct total amount in header" do
      get :index
      expect(response.headers['Total'].to_i).to eq(@objects.size)
    end

    it "correct amount of items on all pages" do        
      get :index, { page: 2 }
      expect(JSON.parse(response.body).size).to eq(@amount_on_second_page)
    end

  end
end