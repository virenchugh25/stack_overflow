FactoryBot.define do
  factory :question_comment, class: 'comment' do
    association :commentable, factory: :question
    text "This is a question's comment"
    user
  end

  factory :answer_comment, class: 'comment' do
    association :commentable, factory: :answer
    text "This is an answer's comment"
    user
  end
end
