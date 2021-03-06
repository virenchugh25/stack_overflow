class Comment < ApplicationRecord
  validates_presence_of :text, :user, :commentable

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  revisable
  ignore_soft_deleted
end
