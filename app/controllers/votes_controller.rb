class VotesController < ApplicationController
  def create
    votable = question_or_answer
    @vote = Vote.find_by(votable: votable, user_id: cookies.signed[:user_id])

    if @vote
      return render json: { error: 'Vote has already been given' }, status: 200 if @vote[:vote_value] == vote_params[:vote_value]
      @vote[:vote_value] = vote_params[:vote_value]
    else
      @vote = Vote.new(votable: votable, user_id: cookies.signed[:user_id], vote_value: vote_params[:vote_value])
    end

    return render json: @vote.errors, status: 500 unless @vote.save
    render json: @vote, status: 201
  end

  def destroy
    @vote = Vote.find_by(id: params[:id], user_id: cookies.signed[:user_id])
    return render json: { error: "Vote not found" }, status: 404 unless @vote

    @vote.deleted_at = Time.now
    return render json: @vote.errors, status: 500 unless @vote.save

    render json: @vote, status: 201
  end

  def question_or_answer
    create_params = vote_params
    Answer.find_by(id: create_params[:answer_id]) if create_params[:answer_id]
    Question.find_by(id: create_params[:question_id]) if create_params[:question_id]
  end

  def vote_params
    return_params = params.require(:vote).permit(:vote_value, :question_id, :answer_id)
    return render json: { error: "Invalid parameters" }, status: 400 if (return_params[:question_id] && return_params[:answer_id]) || (!return_params[:question_id] && !return_params[:answer_id])
    return_params
  end  
end
