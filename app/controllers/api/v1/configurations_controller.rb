class Api::V1::ConfigurationsController < Api::V1::BaseController

  def index
    paginate json: client.configurations, each_serializer: Api::V1::ConfigurationSerializer
  end

  def show
    configuration = client.configurations.find(params[:id])
    render json: configuration, serializer: Api::V1::ConfigurationDetailsSerializer, include: '**'
  end

  def search
    configurations = ::Configuration.search_by_name(client, params[:name])
    paginate json: configurations, each_serializer: Api::V1::ConfigurationSerializer
  end

end