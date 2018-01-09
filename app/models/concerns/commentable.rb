module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, -> { where(deleted_at: nil) }, as: :commentable
  end
end
