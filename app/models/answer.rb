class Answer < ApplicationRecord
    belongs_to :user
    belongs_to :question
    has_many :comments, as :commentable
    has_many :votes, as :votable
    has_many :revisions, as :revisable
end
