class Api::V1::BaseController < SecuredResourceController
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
end