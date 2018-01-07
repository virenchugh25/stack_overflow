class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :authorize, except: [:login, :show, :index]

  def authorize
    @session = Session.active.find_by(user_id: cookies.signed[:user_id], auth_token: cookies.signed[:auth_token])
    render json: { error: 'Not authorized' }, status: 403 unless @session
  end
end
