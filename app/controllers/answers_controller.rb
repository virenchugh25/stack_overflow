class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    return render json: @answer.errors, status: 500 unless @answer.save
    render json: @answer, status: 201
  end

  def update
    @answer = Answer.find_by(id: params[:id], user_id: cookies.signed[:user_id])
    return render json: @answer.errors, status: 500 unless @answer.update_attributes(answer_params)
    render json: @answer, status: 200
  end

  def destroy
    @answer = Answer.find_by(id: params[:id], user_id: cookies.signed[:user_id])
    return render json: { error: "Answer not found" }, status: 404 unless @answer

    @answer.deleted_at = Time.now
    return render json: @answer.errors, status: 500 unless @answer.save

    render json: @answer, status: 201
  end

  def answer_params
    return_params = params.require(:answer).permit(:text, :question_id)
    return_params[:user_id] = cookies.signed[:user_id]
    return_params
  end
end
