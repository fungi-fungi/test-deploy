class Api::V1::RentalsController < Api::V1::BaseController
  
  def suggested
    render json: Item.take(10), each_serializer: Api::V1::ItemSerializer
  end

end