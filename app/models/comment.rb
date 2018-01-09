class Comment < ApplicationRecord
  include Revisable

  validates_presence_of :text, :user, :commentable

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  after_save :create_revision
  default_scope { where(deleted_at: nil) }
end
