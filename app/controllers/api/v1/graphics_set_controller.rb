class Api::V1::GraphicsSetController < Api::V1::BaseController
  
  def index
    configuration = client.configurations.find(params[:configuration_id])

    paginate json: configuration.graphics_sets
  end

  def show
    configuration = client.configurations.find(params[:configuration_id])
    set = configuration.graphics_sets.find(params[:id])

    render json: {}
  end

end