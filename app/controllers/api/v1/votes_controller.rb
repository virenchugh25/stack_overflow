require_relative '../crud_controller'

class Api::V1::VotesController < CRUDController
  def create
    @vote = create_model.first

    if @vote
      return render json: { error: 'Vote has already been given' }, status: 200 if @vote[:vote_value] == filtered_params[:vote_value]
      @vote[:vote_value] = filtered_params[:vote_value]
    else
      create_model.new(filtered_params)
    end

    @vote.save
    render json: @vote, status: 201
  end
  
  def read_model
    return Question.find(params[:question_id]).votes if params[:question_id]
    return Answer.find(params[:answer_id]).votes if params[:answer_id]
    return Vote.all
  end

  def update_model
    current_user.votes.find(params[:id])
  end

  def create_model
    return current_user.votes.where(votable_id: params[:question_id], votable_type: 'Question') if params[:question_id]
    return current_user.votes.where(votable_id: params[:answer_id], votable_type: 'Answer') if params[:answer_id]
  end

  def filtered_params
    params.require(:vote).permit(:vote_value)
  end  
end
