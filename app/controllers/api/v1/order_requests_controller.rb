class Api::V1::OrderRequestsController < Api::V1::BaseController

  def index
    paginate json: client.order_requests, each_serializer: Api::V1::OrderRequestSerializer
  end

  def show
    @order_requests = client.order_requests.where(id: params[:id]).first
    render json: @order_requests, serializer: Api::V1::OrderRequestDetailsSerializer, include: '**'
  end

end