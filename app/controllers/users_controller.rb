class UsersController < ApplicationController
  skip_before_action :authorize, only: :create
  
  def index
    @users = User.active
    render json: @users, status: 200
  end

  def show
    @user = User.active.find_by(id: params[:id])
    return render json: { error: "Not a valid user" }, status: 404 unless @user
    render json: @user, status: 200
  end

  def update
    @user = User.active.find_by(id: params[:id])
    return render json: { error: "Not a valid user" }, status: 404 unless @user
    return render json: @user.errors, status: 500 unless @user.update_attributes(update_user_params)
    render json: @user, status: 200  
  end

  def create
    @user = User.new(user_params)
    return render json: @user.errors, status: 500 unless @user.save
    render json: @user, status: 201
  end

  def destroy
    @user = User.active.find_by(id: params[:id])

    return render json: { error: "Not a valid user" }, status: 404 unless @user
    @user.deleted_at = Time.now
    return render json: @user.errors, status: 500 unless @user.save(validate: false)
    render json: @user, status: 201
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def update_user_params
    params.require(:user).permit(:name, :email)
  end
end
