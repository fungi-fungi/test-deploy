class ErrorsController < SecuredResourceController
  def routing
    not_found("No route matches [#{request.method}] #{request.path}")
  end
end