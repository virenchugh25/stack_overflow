require_relative '../crud_controller'

class Api::V1::UsersController < CRUDController
  skip_before_action :authorize, only: :create
  before_action :check_session, only: :create

  def filtered_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def read_model
    User.all
  end

  def update_model
    current_user
  end

  def create_model
    User
  end
end
