class Api::V1::VotesController < CRUDController
  # Create a new vote for a question or answer
  # create params as per filtered_params
  # @return [json] created vote
  def create
    @vote = create_model.first

    if @vote
      return render json: { error: 'Vote has already been given' }, status: :ok if @vote[:vote_value] == filtered_params[:vote_value]
      @vote[:vote_value] = filtered_params[:vote_value]
    else
      create_model.new(filtered_params)
    end

    @vote.save
    render json: @vote, status: :created
  end

  # Show all votes for a question or answer
  # params may have id (question's or answer's) whose votes are to be shown
  # @return [json] vote list
  def index
    return render json: Question.find(params[:question_id]).votes, status: :ok if params[:question_id]
    render json: Answer.find(params[:answer_id]).votes, status: :ok if params[:answer_id]
  end

  # Updates current user's vote
  # Update params as per filtered_params and answer id
  # @return [json] updated vote
  def update
    vote.update_attributes!(filtered_params)
    render json: vote, status: :ok
  end

  # Soft deleting current user's vote 
  # Params has id of vote
  # return [boolean] true if soft deleted
  def destroy
    render json: vote.destroy!, status: :ok
  end
  
  private
  # Returns votes of question or answer as per input paramter with context of current user
  def create_model
    return current_user.votes.where(votable_id: params[:question_id], votable_type: 'Question') if params[:question_id]
    return current_user.votes.where(votable_id: params[:answer_id], votable_type: 'Answer') if params[:answer_id]
  end

  # Whitelisting parameters to pass to creation or updation
  def filtered_params
    params.require(:vote).permit(:vote_value)
  end  

  # Returns Vote model
  def model
    Vote
  end

  # Returns votes of current user
  def votes
    current_user.votes
  end

  # Returns particular vote of current user
  def vote
    votes.find(params[:id])
  end
end
