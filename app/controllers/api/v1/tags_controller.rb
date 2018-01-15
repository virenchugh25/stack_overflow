require_relative '../crud_controller'

class Api::V1::TagsController < CRUDController
  private

  def create_model
    Tag
  end

  def read_model
    Tag.all
  end

  def update_model
    Tag.find(params[:id])
  end

  def filtered_params
    params.require(:tag).permit(:name, :description)
  end
end
