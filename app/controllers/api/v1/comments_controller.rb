class Api::V1::CommentsController < CRUDController
  # Create a new comment for a question or answer
  # create params as per filtered_params
  # @return [json] created comment
  def create
    render json: create_model.create!(filtered_params), status: :created
  end

  # Show all comments for a question or answer
  # params may have id (question's or answer's) whose comments are to be shown
  # @return [json] comment list
  def index
    return render json: Question.find(params[:question_id]).comments, status: :ok if params[:question_id]
    render json: Answer.find(params[:answer_id]).comments, status: :ok if params[:answer_id]
  end

  # Updates current user's comment
  # Update params as per filtered_params and answer id
  # @return [json] updated comment
  def update
    comment.update_attributes!(filtered_params)
    render json: comment, status: :ok
  end

  # Soft deleting current user's comment 
  # Params has id of comment
  # return [boolean] true if soft deleted
  def destroy
    render json: comment.destroy!, status: :ok
  end
  
  private
  # Returns comments of question or answer as per input paramter with context of current user
  def create_model
    return current_user.comments.where(commentable_id: params[:question_id], commentable_type: 'Question') if params[:question_id]
    return current_user.comments.where(commentable_id: params[:answer_id], commentable_type: 'Answer') if params[:answer_id]
  end

  # Whitelisting parameters to pass to creation or updation
  def filtered_params
    params.require(:comment).permit(:text)
  end

  # Returns Comment model
  def model
    Comment
  end

  # Returns comments of current user
  def comments
    current_user.comments
  end

  # Returns particular comment of current user
  def comment
    comments.find(params[:id])
  end
end
