module RevisionSeeds
  def self.seed
    questions = Question.first(3)
    answers = Answer.first(3)
    revisions = []

    questions.each do |question|
      3.times { |index| revisions << { revisable: question, metadata: { text: "This is revision no #{index + 1}"} } }
    end

    answers.each do |answer|
      3.times { |index| revisions << { revisable: answer, metadata: { text: "This is revision no #{index + 1}"} } }
    end

    Revision.create(revisions)
  end
end