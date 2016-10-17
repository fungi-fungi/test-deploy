class Api::V1::ItemsController < Api::V1::BaseController

  def show
    render json: Item.find(params[:id]), serializer: Api::V1::ItemDetailsSerializer
  end

  def rental

    item = Item.find(params[:id])
    # event = Event.find(params[:event_id])

    #TODO: just for now
    render json: Item.find(params[:id]), serializer: Api::V1::ItemDetailsSerializer

  end

end