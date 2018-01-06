class Vote < ApplicationRecord
	validates_presence_of :user, :votable

	has_many :revisions, as: :revisable

	belongs_to :user
	belongs_to :votable, polymorphic: true

	after_save :create_revision
	scope :active, -> { where(deleted_at: nil) }

	def create_revision
    Revision.create(revisable: self, metadata: { vote_value: self[:vote_value] })
  end
end
