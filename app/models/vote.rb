class Vote < ApplicationRecord
    belongs_to :user
    belongs_to :votable, polymorphic: true
    validates_presence_of :user_id, :votable_id, :votable_type
end
