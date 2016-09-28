class Api::V1::OrderRequestsController < Api::V1::BaseController

  def index
    paginate json: client.order_requests, each_serializer: Api::V1::OrderRequestSerializer
  end

  def show
    @order_requests = client.order_requests.where(id: params[:id]).first
    render json: @order_requests, serializer: Api::V1::OrderRequestDetailsSerializer, include: '**'
  end

  def create
    order = OrderRequest.new
    order.build_request_bom({ request_entities_attributes: transform_entities })
    order.event = Event.find_by(sfid: new_order_params[:event])
    order.account = client
    
    if order.valid?
      order.save
      render json: order, serializer: Api::V1::OrderRequestSerializer, status: :created
    else
      render json: order.errors.to_json, status: :bad_request
    end
  end

  private
  
  def new_order_params
    params.require(:order).permit(:event, entities: [:amount, :item]).delete_if { |k,v| v.nil? || v.empty? }
  end

  def transform_entities
    new_order_params.fetch(:entities).map { |entity| { i_m__amount__c: entity[:amount], i_m__to_item__c: entity[:item] } } unless new_order_params.fetch(:entities).nil?
  end

end