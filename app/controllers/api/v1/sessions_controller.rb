class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorize, only: :create

  def create
    return render json: { message: 'User already logged in' }, status: :found if is_logged_in?
    @user = User.find_by(email: session_params[:email])
    user_session = SessionHandler.new(@user)
    session = Session.create!(user: user_session.authenticate(session_params[:password], cookies), auth_token: cookies.signed[:auth_token])
    render json: {}, status: 201
  end

  def destroy
    user_session = SessionHandler.new(nil)
    user_session.session_destroy(session, cookies)
    render json: {}, status: :ok
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def session
    Session.find_by(auth_token: cookies.signed[:auth_token])
  end

  def is_logged_in?
    cookies.signed[:auth_token] && session
  end
end
