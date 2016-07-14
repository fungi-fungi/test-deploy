class Api::V1::WelcomeController < Api::V1::BaseController

  def index
    @data = {msg: "Hello world"}
    render json: @data
  end
end