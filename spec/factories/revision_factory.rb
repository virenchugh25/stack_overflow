FactoryBot.define do
  factory :question_revision, class: 'revision' do
    association :revisable, factory: :question
    metadata "{ 'text': 'This is the revised question text' }"
  end

  factory :answer_revision, class: 'revision' do
    association :revisable, factory: :answer
    metadata "{ 'text': 'This is the revised answer text' }"
  end

  factory :vote_revision, class: 'revision' do
    association :revisable, factory: :question_vote
    metadata "{ 'vote_value': 1 }"
  end
end
