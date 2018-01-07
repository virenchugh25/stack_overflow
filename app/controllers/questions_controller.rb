class QuestionsController < ApplicationController
  def index
    @questions = Question.active
    render json: @questions, status: 200
  end

  def show
    @question = Question.active.includes(:comments, {:answers => :comments}).find_by(id: params[:id])
    return render json: { error: "Question not found" }, status: 404 unless @question
    render json: @question, status: 200
  end

  def create
    @question = Question.new(question_params)
    return render json: @question.errors, status: 500 unless @question.save
    render json: @question, status: 201  
  end

  def update
    @question = Question.active.find_by(id: params[:id], user_id: cookies.signed[:user_id])
    return render json: { error: "Question not found." }, status: 404 unless @question
    return render json: @question.errors, status: 500 unless @question.update_attributes(question_params)
    render json: @question, status: 200
  end

  def destroy
    @question = Question.active.find_by(id: params[:id], user_id: cookies.signed[:user_id])
    return render json: { error: "Question not found" }, status: 404 unless @question

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
