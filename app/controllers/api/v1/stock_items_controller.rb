class Api::V1::StockItemsController < Api::V1::BaseController

  def index
    paginate json: client.stock_items, each_serializer: Api::V1::StockItemSerializer
  end

  def available
    configuration = client.configurations.where(sfid: params[:configuration_id]).first
    event = Event.where(sfid: params[:event_id]).first

    if !configuration.nil? && !event.nil?
      render json: StockItem.get_stock_for_configuration(event, configuration).to_json
    else
      render json: [].to_json, status: 400
    end
  end

end