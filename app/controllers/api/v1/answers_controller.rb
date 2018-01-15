class Api::V1::AnswersController < CRUDController
  # Create a new answer and its association with given tags
  # input params as per filtered_params
  # @return [json] created answer
  def create
    render json: answers.where(question_id: params[:question_id]).create!(filtered_params), status: :created
  end

  # Show all answers for a user if user_id is recieved. Otherwise it shows all answers
  # input params may have user_id whose answers are to be shown
  # @return [json] answer list
  def index
    return render json: Question.find(params[:question_id]).answers, status: :ok if params[:question_id]
    super
  end

  # Updates current user's asnwer
  # input params as per filtered_params and answer id
  # @return [json] updated answer
  def update
    answer.update_attributes!(filtered_params)
    render json: answer, status: :ok
  end

  # Soft deleting current user's answer 
  # input params has id of answer
  # return [boolean] true if soft deleted
  def destroy
    render json: answer.destroy!, status: :ok
  end

  private
  # Whitelisting parameters to pass to creation or updation
  def filtered_params
    params.require(:answer).permit(:text)
  end

  # return Answer model
  def model
    Answer
  end

  # Get particular answer of current user
  def answer
    answers.find(params[:id])
  end

  # Get all answers of current user
  def answers
    current_user.answers
  end
end
