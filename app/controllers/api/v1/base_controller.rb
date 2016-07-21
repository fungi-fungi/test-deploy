class Api::V1::BaseController < SecuredResourceController
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  def user_sfid
    @current_user[:user_metadata]['sf_id']
  end

  def client
    Account.where(sfid: user_sfid).first
  end
end