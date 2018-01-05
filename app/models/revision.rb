class Revision < ApplicationRecord
	validates_presence_of :revisable

	belongs_to :revisable, polymorphic: true
end
