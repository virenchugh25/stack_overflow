require_relative '../crud_controller'

class Api::V1::QuestionsController < CRUDController
  private
  
  def read_model
    return Question.where(user_id: params[:user_id]) if params[:user_id]
    return Question.includes(:comments, {:answers => :comments}) if params[:id]
    Question.all
  end

  def update_model
    current_user.questions.find(params[:id])
  end

  def create_model
    current_user.questions
  end

  def filtered_params
    params.require(:question).permit(:text)
  end
end
