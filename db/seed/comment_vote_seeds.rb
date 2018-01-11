module CommentVoteSeeds
  def self.seed
    users = User.first(3)
    questions = Question.first(3)
    answers = Answer.first(3)
    votes = []
    comments = []

    questions.each do |question|
      users.each do |user|
        votes << { vote_value:  1, votable: question, user: user }
        comments << { text:  "Comment for question #{question[:id]}", commentable: question, user: user }
      end
    end

    answers.each do |answer|
      users.each do |user|
        votes << { vote_value: -1, votable: answer, user: user }
        comments << { text: "Comment for answer #{answer[:id]}", commentable: answer, user: user }
      end
    end

    Vote.create(votes)
    Comment.create(comments)
  end
end