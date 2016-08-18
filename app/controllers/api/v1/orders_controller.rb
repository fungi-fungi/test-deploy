class Api::V1::OrdersController < Api::V1::BaseController

  def index
    paginate json: client.order_requests, each_serializer: Api::V1::OrderRequestSerializer
  end

  def create
    @order_request = OrderRequest.new(account: client)
    if @order_request.save
      render json: @order_request, serializer: Api::V1::OrderRequestSerializer
    end
  end

end