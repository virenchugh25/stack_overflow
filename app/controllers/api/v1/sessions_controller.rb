class Api::V1::SessionsController < ApplicationController
  before_action :session_destroy, only: :destroy
  before_action :authenticate, only: :create

  
  def create
    @user = User.find_by(email: session_params[:email])
    return render json: { error: 'Authentication failure' }, status: 401 unless authenticate
    set_new_session
    render json: {}, status: 201
  end

  def destroy
    render json: {}, status: :ok
  end

  def login
    return render json: { message: 'User already logged in' }, status: :found if is_logged_in?
    create
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def session
    Session.find_by(auth_token: cookies.signed[:auth_token])
  end
end
