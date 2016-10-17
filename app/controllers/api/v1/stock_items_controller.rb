class Api::V1::StockItemsController < Api::V1::BaseController

  def index
    if params[:category_id]
      category = Category.find(params[:category_id])
      # event = Event.find(params[:event_id])
      paginate json: StockItem.for_account(client).for_category(category), each_serializer: Api::V1::StockItemSerializer
    else
      paginate json: StockItem.for_account(client), each_serializer: Api::V1::StockItemSerializer
    end
  end

  def show
    stock_item = client.stock_items.find_by(id: params[:id]) or no_such_record
    render json: stock_item, serializer: Api::V1::StockItemSerializer
  end

end