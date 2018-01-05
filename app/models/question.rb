class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :revisions, as: :revisable
  has_many :tags, through: :tag_associations
  has_many :tag_associations, as: :tagable
  validates_presence_of :text, :user_id
end
