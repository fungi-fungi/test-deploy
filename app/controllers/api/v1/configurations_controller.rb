class Api::V1::ConfigurationsController < Api::V1::BaseController

  def index
    paginate json: client.configurations, each_serializer: Api::V1::ConfigurationSerializer
  end
end