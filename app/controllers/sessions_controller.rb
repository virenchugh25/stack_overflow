class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.active.find_by(email: session_params[:email])
    return render json: { error: 'Could not log in' }, status: 500 unless user && user.authenticate(session_params[:password])

    cookies.signed[:user_id] = user.id
    cookies.signed[:auth_token] = SecureRandom.hex(12)
    Session.create(user: user, auth_token: cookies.signed[:auth_token])
 
    render json: {}, status: 201
  end

  def login
    return render json: { message: 'User already logged in' }, status: 302 if is_logged_in?
    create
  end

  def is_logged_in?
    cookies.signed[:auth_token] && Session.active.find_by(auth_token: cookies.signed[:auth_token])
  end

  def destroy
    @session = Session.active.find_by(auth_token: cookies.signed[:auth_token])
    if @session
      @session[:deleted_at] = Time.now
      return render json: { error: 'Could not log out successfully' }, status: 500 unless @session.save
    end

    cookies.delete(:user_id)
    cookies.delete(:auth_token)
    render json: {}, status: 200
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
