require 'bcrypt'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require_relative './seed/user_seeds.rb'
require_relative './seed/question_seeds.rb'
require_relative './seed/answer_seeds.rb'
require_relative './seed/comment_vote_seeds.rb'
require_relative './seed/session_seeds.rb'
require_relative './seed/revision_seeds.rb'
require_relative './seed/tag_seeds.rb'
require_relative './seed/question_tag_seeds.rb'

UserSeeds.seed
QuestionSeeds.seed
AnswerSeeds.seed
CommentVoteSeeds.seed
SessionSeeds.seed
RevisionSeeds.seed
TagSeeds.seed
QuestionTagSeeds.seed
