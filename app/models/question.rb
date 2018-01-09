class Question < ApplicationRecord
  include Revisable
  include Commentable
  include Votable

  validates_presence_of :text, :user

  belongs_to :user

  has_many :answers, -> { where(deleted_at: nil) }
  has_and_belongs_to_many :tags

  default_scope { where(deleted_at: nil) }
end
