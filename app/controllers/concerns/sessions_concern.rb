module SessionsConcern
  extend ActiveSupport::Concern
  
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

  def is_logged_in?
    cookies.signed[:auth_token] && session
  end

  def set_new_session
    cookies.signed[:user_id] = @user.id
    cookies.signed[:auth_token] = SecureRandom.hex(12)
    session = Session.create!(user: @user, auth_token: cookies.signed[:auth_token])
  end

  def session_destroy
    session.destroy!
    cookies.delete(:user_id)
    cookies.delete(:auth_token)
  end

  def authenticate
    @user && @user.authenticate(session_params[:password])
  end
end