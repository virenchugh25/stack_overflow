class Vote < ApplicationRecord
	validates_presence_of :user, :votable, :vote_value

	belongs_to :user
	belongs_to :votable, polymorphic: true

	revisable
	ignore_soft_deleted
end
