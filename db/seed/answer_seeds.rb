module AnswerSeeds
  def self.seed
    users = User.first(3)
    questions = Question.first(3)
    answers = []

    questions.each do |question|
      users.each { |user| answers << { text: "This is answer for question #{question.id} by user #{user.id}", question: question, user: user } }
    end
    Answer.create(answers)
  end
end
