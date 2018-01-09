FactoryBot.define do
  factory :answer do |f|
    f.text Faker::RickAndMorty.character
    question
    user
  end
end
