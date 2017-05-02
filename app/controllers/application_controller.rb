class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :current_user
  helper_method :authorize!
  def current_user
    if request.headers["HTTP_AUTHORIZATION"]
      @current_user ||= User.find_by(authorization_token: request.headers["HTTP_AUTHORIZATION"].split(" ").last)
    end
  end

  def authorize!
    unless current_user
      render json: {message: "Please log in"}
    end
  end
end
