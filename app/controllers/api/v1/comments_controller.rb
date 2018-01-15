require_relative '../crud_controller'

class Api::V1::CommentsController < CRUDController
  private

  def read_model
    return Question.find(params[:question_id]).comments if params[:question_id]
    return Answer.find(params[:answer_id]).comments if params[:answer_id]
    return Comment.all
  end

  def update_model
    current_user.comments.find(params[:id])
  end

  def create_model
    return current_user.comments.where(commentable_id: params[:question_id], commentable_type: 'Question') if params[:question_id]
    return current_user.comments.where(commentable_id: params[:answer_id], commentable_type: 'Answer') if params[:answer_id]
  end

  def filtered_params
    params.require(:comment).permit(:text)
  end  
end
