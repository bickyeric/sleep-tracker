class ApplicationController < ActionController::API
  rescue_from StandardError do |exception|
    raise exception if Rails.env.development?

    render json: { error: 'Internal Server Error' }, status: :internal_server_error
  end

  private

  def current_user
    @current_user ||= User.find current_user_id
  end

  def current_user_id
    request.headers['Authorization']
  end
end
