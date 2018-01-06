class Comment < ApplicationRecord
  validates_presence_of :text, :user, :commentable

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :revisions, as: :revisable

  after_save :create_revision
  scope :active, -> { where(deleted_at: nil) }

  def create_revision
    Revision.create(revisable: self, metadata: { text: self[:text] })
  end
end
