class Api::V1::SuggestedRentalSetController < Api::V1::BaseController
  
  def show
    paginate json: SuggestedRentalSet.find(params[:id]).items, each_serializer: Api::V1::ItemDetailsSerializer
  end

end