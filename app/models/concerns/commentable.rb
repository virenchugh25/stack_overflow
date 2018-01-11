module Commentable
  extend ActiveSupport::Concern

  included do
    def self.commentable
      has_many :comments, -> { where(deleted_at: nil) }, as: :commentable
    end
  end
end
