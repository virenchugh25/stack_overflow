class Answer < ApplicationRecord
  include Revisable
  include Commentable
  include Votable

  validates_presence_of :text, :user, :question

  belongs_to :user
  belongs_to :question

  after_save :create_revision
  scope :active, -> { where(deleted_at: nil) }
end
