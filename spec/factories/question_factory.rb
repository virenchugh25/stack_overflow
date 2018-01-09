FactoryBot.define do
  factory :question do |f|
    f.text Faker::GameOfThrones.character
    user
  end
end
