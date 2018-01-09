class Vote < ApplicationRecord
	include Revisable

	validates_presence_of :user, :votable, :vote_value

	belongs_to :user
	belongs_to :votable, polymorphic: true

	after_save :create_revision

	default_scope { where(deleted_at: nil) }
end
