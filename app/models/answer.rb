class Answer < ApplicationRecord
  validates_presence_of :text, :user, :question

  belongs_to :user
  belongs_to :question

  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :revisions, as: :revisable

  after_save :create_revision
  default_scope { where(deleted_at: nil) }

  def create_revision
    Revision.create(revisable: self, metadata: { text: self[:text] })
  end
end
