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
users = [{ name: 'Viren Chugh', email: 'viren.chugh@1mg.com', salt: SecureRandom.hex(12) },
         { name: 'Aamod', email: 'aa@aa.com', salt: SecureRandom.hex(12) },
         { name: 'Asura', email: 'asura@gmail.com', salt: SecureRandom.hex(12) }]

users.each do |user|
    user[:enc_password] = BCrypt::Password.create(user[:salt] + 'abcd')
    User.create(user)
end

# Seeding for questions table
users = User.all

users.each { |user| Question.create(text: "This is question for user #{user.id}", user: user) }

# Seeding for answers table
users = User.all
questions = Question.all

questions.each do |question|
    users.each { |user| Answer.create(text: "This is answer for question #{question.id} by user #{user.id}", question: question, user: user) }
end

# Seeding for votes and comments
users = User.first(3)
questions = Question.first(3)
answers = Answer.first(3)

questions.each do |question|
    users.each do |user|
        Vote.create(vote_value:  1, votable: question, user: user)
        Comment.create(text:  "Comment for question #{question[:id]}", commentable: question, user: user)
    end
end

answers.each do |answer|
    users.each do |user| 
        Vote.create(vote_value: -1, votable: answer, user: user)
        Comment.create(text: "Comment for answer #{answer[:id]}", commentable: answer, user: user)
    end
end

# Seeding for tags
tags = [{ name: 'Node', description: 'This is node' },
       { name: 'C', description: 'This is C' },
       { name: 'C++', description: 'This is C++' }]

Tag.create(tags)

# Seeding for sessions
new_proc = Proc.new{ |user| 3.times { Session.create(user: user, auth_token: SecureRandom.hex(12)) } }
iterate_and_execute(users, new_proc)

# Seeding for revisions
new_proc = Proc.new { |question| 3.times { |index| Revision.create(revisable: question, metadata: {text: "This is a revision no #{index}"}) } }
iterate_and_execute(questions, new_proc)

new_proc = Proc.new { |answer| 3.times { |index| Revision.create(revisable: answer, metadata: {text: "This is revision no #{index}"}) } }
iterate_and_execute(answers, new_proc)

# Seeding for tag_associations
tags = Tag.first(3)

tags.each do |tag|
    questions.each { |question| TagAssociation.create(tag: tag, tagable: question)}
end
