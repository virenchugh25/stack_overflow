require 'bcrypt'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def iterate_and_execute(list, proc)
	list.each { |item| proc.call(item) }
end


# Seeding for users table
users = [{ name: 'Viren Chugh', email: 'viren.chugh@1mg.com' },
	{ name: 'Aamod', email: 'aa@aa.com' },
	{ name: 'Asura', email: 'asura@gmail.com' }]

users.each do |user|
	user[:password_digest] = BCrypt::Password.create('abcd')	
end
User.create(users)

# Seeding for questions table
users = User.first(3)
questions = []
users.each { |user| questions << { text: "This is question for user #{user.id}", user: user } }
Question.create(questions)

# Seeding for answers table
questions = Question.first(3)
answers = []

questions.each do |question|
	users.each { |user| answers << { text: "This is answer for question #{question.id} by user #{user.id}", question: question, user: user } }
end
Answer.create(answers)

# Seeding for votes and comments
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


# Seeding for tags
tags = [{ name: 'Node', description: 'This is node' },
	{ name: 'C', description: 'This is C' },
	{ name: 'C++', description: 'This is C++' }]

Tag.create(tags)


# Seeding for sessions
sessions = []
users.each do |user| 
	3.times { sessions << { user: user, auth_token: SecureRandom.hex(12) } }
end
Session.create(sessions)


# Seeding for revisions
revisions = []
questions.each do |question|
	3.times { |index| revisions << { revisable: question, metadata: { text: "This is revision no #{index + 1}"} } }
end

answers.each do |answer|
	3.times { |index| revisions << { revisable: answer, metadata: { text: "This is revision no #{index + 1}"} } }
end

Revision.create(revisions)


# Seeding for tag_associations
tags = Tag.first(3)

questions.each do |question|
	question.tags = tags
end
