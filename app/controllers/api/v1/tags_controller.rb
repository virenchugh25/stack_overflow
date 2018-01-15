class Api::V1::TagsController < CRUDController
  private

  # Whitelisting parameters to pass to creation or updation
  # input params name and description are permitted
  # @return whitelisted object
  def filtered_params
    params.require(:tag).permit(:name, :description)
  end

  # returns Tag model
  def model
    Tag
  end
end
