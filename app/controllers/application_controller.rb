class ApplicationController < ActionController::Base
  include Knock::Authenticable
  protect_from_forgery with: :null_session
  
  def not_found(msg)
    return api_error(status: 404, errors: [msg])
  end

  def api_error(status: 500, message: 'Not found.', errors: [])
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: { message: message, errors: errors}, status: status
  end
end
