class Api::V1::QuestionsController < CRUDController
  # Create a new question and its association with given tags
  # input params as per filtered_params
  # @return [json] created question
  def create
    return  render json: { error: 'Please enter minimum 1 tag and maximum of 5 tags' }, status: :bad_request unless filtered_params[:tags] && filtered_params[:tags].length.between?(1, 5)
    render json: questions.create!(text: filtered_params[:text], tags: Tag.where(id: filtered_params[:tags])), status: :created
  end

  # Show all questions for a user if user_id is recieved. Otherwise it shows all questions
  # input params may have user_id whose questions are to be shown
  # @return [json] question list
  def index
    return render json: Question.where(user_id: params[:user_id]), status: :ok if params[:user_id]
    super
  end

  # Show a particlar question with it's answers and comments
  # input params has id of question
  # @return [json] question details
  def show
    render json: Question.includes(:comments, {:answers => :comments}).find(params[:id])
  end

  # Updates current user's question
  # input params as per filtered_params and question id
  # @return [json] updated question
  def update
    question.update_attributes!(filtered_params)
    render json: question, status: :ok
  end

  # Soft deleting current user's question 
  # input params has id of question
  # return [boolean] true if soft deleted
  def destroy
    render json: question.destroy!, status: :ok
  end

  private
  # Whitelisting parameters to pass to creation or updation
  def filtered_params
    @filtered_params ||= params.require(:question).permit(:text, :tags => [])
  end

  # Get all questions for current user
  def questions
    current_user.questions
  end

  # Get particular question for current user
  def question
    questions.find(params[:id])
  end

  # Defining model to pass to CRUD controller
  def model
    Question
  end
end
