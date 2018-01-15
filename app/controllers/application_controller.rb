class ApplicationController < ActionController::Base
  include ErrorHandler

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :authorize, except: [:login, :show, :index]

  def current_user
    @current_user ||= current_session.try(:user)
  end

  def current_session
    @current_session ||= Session.find_by(auth_token: cookies.signed[:auth_token])
  end

  def authorize
    render json: { error: 'Not authorized' }, status: :unauthorized unless current_user
  end

  def check_session
    render json: { error: 'Need to log out' }, status: :unauthorized if current_session.present?
  end
end
