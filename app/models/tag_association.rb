class TagAssociation < ApplicationRecord
    belongs_to :tag
    belongs_to :tagable, polymorphic: true
    validates_presence_of :tag_id, :tagable_id, :tagable_type
end
