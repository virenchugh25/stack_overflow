module QuestionTagSeeds
  def self.seed
    questions = Question.first(3)
    tags = Tag.first(3)

    questions.each do |question|
      question.tags = tags
    end
  end
end
