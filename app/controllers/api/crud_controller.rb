class CRUDController < ApplicationController
  def index
    render json: read_model, status: :ok
  end

  def show
    render json: read_model.find(params[:id]), status: :ok
  end

  def create
    render json: create_model.create!(filtered_params), status: :created
  end

  def update
    render json: update_model.update_attributes!(filtered_params), status: :ok
  end

  def destroy
    render json: update_model.destroy!, status: :ok
  end
end