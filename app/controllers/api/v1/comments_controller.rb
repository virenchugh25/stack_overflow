class Api::V1::CommentsController < ApplicationController
  def create
    render json: Comment.create!(comment_params.merge(commentable: question_or_answer, user_id: cookies.signed[:user_id])), status: 201
  end

  def update
    render json: comment.update_attributes!(comment_params), status: 200
  end

  def destroy
    render json: comment.destroy!, status: 200
  end

  private

  def question_or_answer
    return Answer.find(params[:answer_id]) if params[:answer_id]
    return Question.find(params[:question_id]) if params[:question_id]
  end

  def comment
    current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end  
end
