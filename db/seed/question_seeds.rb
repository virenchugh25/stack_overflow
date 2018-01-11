module QuestionSeeds
  def self.seed
    users = User.first(3)
    questions = []
    users.each { |user| questions << { text: "This is question for user #{user.id}", user: user } }
    Question.create(questions)
  end
end