class Api::V1::BomsController < Api::V1::BaseController

  def show
    render json: Bom.find(params[:id]), serializer: Api::V1::BomSerializer
  end

  def stock
    event = Event.find(params[:event_id])
    bom = Bom.find(params[:id])

    #TODO Move here quering ovelaped order_requests

    bom_stock = BomStock.new({ id: bom.id, event: event, bom: bom })

    render json: bom_stock, serializer: Api::V1::BomStockSerializer
  end

end