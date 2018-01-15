class Api::V1::UsersController < CRUDController
  # Skip authorization because user will not be signed in before signing up
  skip_before_action :authorize, only: :create

  # Check there is no active session while signing up
  before_action :check_session, only: :create

  # Whitelisting parameters to pass to creation or updation
  # input params name, email, password and password_confirmation are permitted
  # @return whitelisted object
  def filtered_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Defining model to pass to CRUD controller
  def model
    User
  end
end
