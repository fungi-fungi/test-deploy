class Api::V1::EventsController < Api::V1::BaseController
  
  def index
    paginate json: Event.all, each_serializer: Api::V1::EventSerializer
  end

  def show
    render json: Event.find(params[:id]), serializer: Api::V1::EventSerializer
  end

  def search
    paginate json: Event.search_by_name(params[:name]), each_serializer: Api::V1::EventSerializer
  end

end