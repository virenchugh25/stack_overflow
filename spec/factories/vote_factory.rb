FactoryBot.define do
  factory :question_vote, class: 'vote' do
    association :votable, factory: :question
    vote_value -1
    user
  end

  factory :answer_vote, class: 'vote' do
    association :votable, factory: :answer
    vote_value 1
    user
  end
end
