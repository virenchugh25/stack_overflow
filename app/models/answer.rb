class Answer < ApplicationRecord
  validates_presence_of :text, :user, :question

  belongs_to :user
  belongs_to :question

  commentable
  ignore_soft_deleted
  revisable
  votable
end
