class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :current_user
  def current_user
    if request.headers["HTTP_AUTHORIZATION"].split(" ").last
      @current_user ||= User.find_by(authorization_token: request.headers["HTTP_AUTHORIZATION"].split(" ").last)
    end
  end
end
