class Question < ApplicationRecord
  validates_presence_of :text, :user

  belongs_to :user

  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :revisions, as: :revisable
  has_and_belongs_to_many :tags

  after_save :create_revision
  scope :active, -> { where(deleted_at: nil) }

  def create_revision
    Revision.create(revisable: self, metadata: { text: self[:text] })
  end
end
