require_relative '../crud_controller'

class Api::V1::QuestionsController < CRUDController
  def create
    return  render json: { error: 'Please enter minimum 1 tag and maximum of 5 tags' }, status: :bad_request unless filtered_params[:tags] && filtered_params[:tags].length.between?(1, 5)
    @question = current_user.questions.create!(text: filtered_params[:text])
    @question.tags = Tag.where(id: filtered_params[:tags])
    render json: @question, status: :created
  end

  private

  def read_model
    return Question.where(user_id: params[:user_id]) if params[:user_id]
    return Question.includes(:comments, {:answers => :comments}) if params[:id]
    Question.all
  end

  def update_model
    current_user.questions.find(params[:id])
  end

  def filtered_params
    @filtered_params ||= params.require(:question).permit(:text, :tags => [])
  end
end
