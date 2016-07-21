class Api::V1::StockItemsController < Api::V1::BaseController

  def index
    paginate json: client.stock_items, each_serializer: Api::V1::StockItemSerializer
  end
end