class Question < ApplicationRecord
  validates_presence_of :text, :user

  belongs_to :user

  has_many :answers, -> { where(deleted_at: nil) }
  has_and_belongs_to_many :tags

  commentable
  revisable
  votable
  ignore_soft_deleted
end
