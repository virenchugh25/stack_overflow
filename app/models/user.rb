class User < ApplicationRecord
    has_many :questions
    has_many :answers
    has_many :sessions
    has_many :votes
    has_many :comments
    validates_presence_of :email
    validates_uniqueness_of :email
end
