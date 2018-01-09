class CommentsController < ApplicationController
  def create
    @comment = Comment.new(text: comment_params[:text], commentable: question_or_answer, user_id: cookies.signed[:user_id])
    return render json: @comment.errors, status: 500 unless @comment.save
    render json: @comment, status: 201
  end

  def update
    @comment = Comment.find_by(id: params[:id], user_id: cookies.signed[:user_id])
    return render json: { error: "Comment not found." }, status: 404 unless @comment
    return render json: @comment.errors, status: 500 unless @comment.update_attributes(text: comment_params[:text])
    render json: @comment, status: 200
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], user_id: cookies.signed[:user_id])
    return render json: { error: "Comment not found" }, status: 404 unless @comment
    
    @comment[:deleted_at] = Time.now
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
    return_params
  end  
end
