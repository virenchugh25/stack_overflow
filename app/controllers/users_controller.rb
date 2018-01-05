class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    @user = User.find(params[:id])
    render json: @user, status: 200
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render json: @user, status: 200
    else
      render json: @user.errors, status: 500
    end
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user[:salt] = SecureRandom.hex(12)
    # @user[:enc_password] = BCrypt::Password.create(@user[:salt] + @user[:password])
    if @user.save
      render json: @user, status: 201
    else
      render json: @user.errors, status: 500
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.deleted_at = Time.now
    if @user.save
      render json: @user, status: 201
    else
      render json: @user.errors, status: 500
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
