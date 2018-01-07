class Vote < ApplicationRecord
	include Revisable

	validates_presence_of :user, :votable

	belongs_to :user
	belongs_to :votable, polymorphic: true

	after_save :create_revision
	scope :active, -> { where(deleted_at: nil) }
end
