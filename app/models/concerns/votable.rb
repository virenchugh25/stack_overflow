module Votable
  extend ActiveSupport::Concern

  included do
    def self.votable
      has_many :votes, as: :votable
    end
  end
end
