class Api::V1::ConfigurationsController < Api::V1::BaseController

  def index
    paginate json: client.configurations, each_serializer: Api::V1::ConfigurationSerializer
  end

  def show
    @configuration = client.configurations.where(id: params[:id]).first
    render json: @configuration, serializer: Api::V1::ConfigurationDetailsSerializer
  end
end