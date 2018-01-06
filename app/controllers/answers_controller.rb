class AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    @answer = Answer.find(params[:id])
    if @answer.update_attributes(answer_params)
      render json: @answer, status: 200
    else
      render json: @answer.errors, status: 500
    end
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      render json: @answer, status: 201
    else
      render json: @answer.errors, status: 500
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.deleted_at = Time.now
    if @answer.save
      render json: @answer, status: 201
    else
      render json: @answer.errors, status: 500
    end
  end

  def answer_params
    params.require(:answer).permit(:text, :user_id, :question_id)
  end
end
