class Api::V1::CategorySetsController < Api::V1::BaseController

  def show
    render json: CategorySet.find(params[:id]), serializer: Api::V1::CategorySetSerializer
  end

  def stock
    event = Event.find(params[:event_id])
    category_set = CategorySet.find(params[:id])

    category_set_stock = CategorySetStock.new({ id: category_set.id, event: event, category_set: category_set })

    render json: category_set_stock, serializer: Api::V1::CategorySetStockSerializer
  end

end