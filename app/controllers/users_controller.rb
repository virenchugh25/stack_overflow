class UsersController < ApplicationController
  skip_before_action :authorize, only: :create

  def create
    @user = User.new(user_params)
    return render json: @user.errors, status: 500 unless @user.save
    render json: @user, status: 201
  end
  
  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    @user = User.find_by(id: params[:id])
    return render json: { error: "Not a valid user" }, status: 404 unless @user
    render json: @user, status: 200
  end

  def update
    return render json: { error: "Not a valid user" }, status: 404 unless get_user
    return render json: @user.errors, status: 500 unless @user.update_attributes(update_user_params)
    render json: @user, status: 200  
  end

  def destroy
    return render json: { error: "Not a valid user" }, status: 404 unless get_user
    @user.deleted_at = Time.now
    return render json: @user.errors, status: 500 unless @user.save(validate: false)
    delete_sessions
    render json: @user, status: 201
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def update_user_params
    params.require(:user).permit(:name, :email)
  end

  def get_user
    @user = User.find_by(id: params[:id]) if cookies.signed[:user_id] == params[:id].to_i
  end

  def delete_sessions
    @user.sessions.update_all(deleted_at: Time.now)
  end
end
