class CRUDController < ApplicationController
  def index
    render json: model.all, status: :ok
  end

  def show
    render json: find_one, status: :ok
  end

  def create
    render json: model.create!(filtered_params), status: :created
  end

  def update
    find_one.update_attributes!(filtered_params)
    render json: find_one, status: :ok
  end

  def destroy
    render json: find_one.destroy!, status: :ok
  end

  def find_one
    model.find(params[:id])
  end
end