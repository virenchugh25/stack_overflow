class ApplicationController < ActionController::Base
  include SessionsConcern
  include ErrorHandler

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :authorize, except: [:login, :show, :index]
end
