class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    @comment = Comment.find(params[:id])
    return render json: @comment.errors, status: 500 unless @comment.update_attributes(text: comment_params[:text])
    render json: @comment, status: 200
  end

  def create
    @comment = Comment.new(text: comment_params[:text], commentable: question_or_answer, user_id: cookies.signed[:user_id])
    return render json: @comment.errors, status: 500 unless @comment.save
    render json: @comment, status: 201
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.deleted_at = Time.now

    return render json: @comment.errors, status: 500 unless @comment.save
    render json: @comment, status: 201
  end

  def question_or_answer
    create_params = comment_params
    Answer.find_by(id: create_params[:answer_id]) if create_params[:answer_id]
    Question.find_by(id: create_params[:question_id]) if create_params[:question_id]
  end

  def comment_params
    return_params = params.require(:comment).permit(:text, :question_id, :answer_id)
    return render json: { error: "Invalid parameters" }, status: 400 if (return_params[:question_id] && return_params[:answer_id]) || (!return_params[:question_id] && !return_params[:answer_id])
    return_params
  end  
end
