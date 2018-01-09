class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: session_params[:email])
    return render json: { error: 'Authentication failure' }, status: 401 unless @user && @user.authenticate(session_params[:password])
    set_new_session
  end

  def destroy
    @session = Session.find_by(auth_token: cookies.signed[:auth_token])
    if @session
      @session[:deleted_at] = Time.now
      return render json: { error: 'Could not log out successfully' }, status: 500 unless @session.save
    end

    cookies.delete(:user_id)
    cookies.delete(:auth_token)
    render json: {}, status: 200
  end

  def login
    return render json: { message: 'User already logged in' }, status: 302 if is_logged_in?
    create
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def is_logged_in?
    cookies.signed[:auth_token] && Session.find_by(auth_token: cookies.signed[:auth_token])
  end

  def set_new_session
    cookies.signed[:user_id] = @user.id
    cookies.signed[:auth_token] = SecureRandom.hex(12)
    session = Session.new(user: @user, auth_token: cookies.signed[:auth_token])
    return render json: session.error, status: 500 unless session.save
    render json: {}, status: 201
  end
end
