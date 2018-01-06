class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    @questions = Question.active
    render json: @questions, status: 200
  end

  def show
    @question = Question.active.includes(:comments, {:answers => :comments}).find(params[:id])
    render json: @question, status: 200
  end

  def update
    @question = Question.active.find(params[:id])
    return render json: @question.errors, status: 500 unless @question.update_attributes(question_params)
    render json: @question, status: 200
  end

  def create
    @question = Question.new(question_params)
    return render json: @question.errors, status: 500 unless @question.save
    render json: @question, status: 201  
  end

  def destroy
    @question = Question.active.find(params[:id])
    @question.deleted_at = Time.now
    return render json: @question.errors, status: 500 unless @question.save
    render json: @question, status: 201
  end

  def question_params
    return_params = params.require(:question).permit(:text)
    return_params[:user_id] = cookies.signed[:user_id]
    return_params
  end
end
