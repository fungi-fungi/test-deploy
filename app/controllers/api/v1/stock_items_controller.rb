class Api::V1::StockItemsController < Api::V1::BaseController

  def index
    paginate json: client.stock_items, each_serializer: Api::V1::StockItemSerializer
  end

  def show
    stock_item = client.stock_items.find_by(id: params[:id]) or no_such_record
    render json: stock_item, serializer: Api::V1::StockItemSerializer
  end

end