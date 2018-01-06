class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.active.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    #redirect_to '/login' unless current_user
    render json: { error: 'Not authorized' }, status: 403
  end
end
