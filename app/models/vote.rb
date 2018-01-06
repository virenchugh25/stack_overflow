class Vote < ApplicationRecord
	validates_presence_of :user, :votable

	belongs_to :user
	belongs_to :votable, polymorphic: true

	scope :active, -> { where(deleted_at: nil) }
end
