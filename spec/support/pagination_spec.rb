RSpec.shared_examples "a paginable" do |object_factory, params = {}|
  
  context "response returns" do

    before(:each) do
      
      @request_params = {}
      @amount_on_second_page = 5

      if params.empty?
        @objects = FactoryGirl.create_list(object_factory, WillPaginate.per_page + @amount_on_second_page)
      
      else
        parent_object = FactoryGirl.create(params[:factory_name])
        @objects = FactoryGirl.create_list(object_factory, WillPaginate.per_page + @amount_on_second_page, params[:name] => parent_object)
        @request_params = Hash[params[:id_name], parent_object.id]
      end
    end
    
    it "correct amount of records" do
      get :index, @request_params
      expect(JSON.parse(response.body).size).to eq(WillPaginate.per_page)
    end

    it "correct records per page in header" do
      get :index, @request_params
      expect(response.headers['Per-Page'].to_i).to be == WillPaginate.per_page
    end

    it "correct total @request_params in header" do
      get :index, @request_params
      expect(response.headers['Total'].to_i).to eq(@objects.size)
    end

    it "correct amount of items on all pages" do        
      get :index, @request_params.merge({ page: 2 })
      expect(JSON.parse(response.body).size).to eq(@amount_on_second_page)
    end

  end
end