class Api::V1::GraphicsSetController < Api::V1::BaseController
  
  def index
    configuration = client.configurations.find(params[:configuration_id])

    render json: configuration, serializer: Api::V1::ConfigurationWithGraphicsSetsSerializer
  end

  def show
    configuration = client.configurations.find(params[:configuration_id])
    set = configuration.graphics_sets.find(params[:id])

    render json: set, serializer: Api::V1::GraphicsSetWithEntitiesSerializer
  end

  def graphics
    configuration = client.configurations.find(params[:configuration_id])
    set = configuration.graphics_sets.find(params[:id])

    # TODO: change to GraphicEntityDetailsSerializer
    render json: set, serializer: Api::V1::GraphicsSetWithEntitiesSerializer
  end

end