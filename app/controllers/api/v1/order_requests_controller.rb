class Api::V1::OrderRequestsController < Api::V1::BaseController

  def index
    paginate json: client.order_requests, each_serializer: Api::V1::OrderRequestSerializer
  end

  def show
    order_requests = client.order_requests.where(id: params[:id]).first
    render json: order_requests, serializer: Api::V1::OrderRequestDetailsSerializer, include: '**'
  end

  def create
    order = OrderRequest.new
    order.build_request_bom({ request_entities_attributes: transform_entities })
    order.event = Event.find_by(sfid: new_order_params[:event])
    order.configuration = ::Configuration.find_by(sfid: new_order_params[:configuration]) if new_order_params[:configuration]
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
    params.require(:order).permit(:event, :configuration, entities: [:amount, :sfid, :provider]).delete_if { |_,v| v.nil? || v.empty? }
  end

  def transform_entities
    new_order_params.fetch(:entities).map { |entity| transform_entitie(entity) } unless new_order_params.fetch(:entities).nil?
  end

  def transform_entitie(entity)
    { i_m__amount__c: entity[:amount], i_m__to_item__c: entity[:sfid], i_m__provider__c: entity[:provider] }
  end

end