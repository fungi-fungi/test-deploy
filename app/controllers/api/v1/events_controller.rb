class Api::V1::EventsController < Api::V1::BaseController
  
  def index
    paginate json: Event.all, each_serializer: Api::V1::EventSerializer
  end

end