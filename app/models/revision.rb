class Revision < ApplicationRecord
    belongs_to :revisable, polymorphic: true
    validates_presence_of :revisable_id, :revisable_type
end
