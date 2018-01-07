module Revisable
  extend ActiveSupport::Concern

  included do
    has_many :revisions, as: :revisable
  end

  def create_revision
    metadata = { text: self[:text] }
    metadata = { vote_value: self[:vote_value] } if self[:vote_value]
    Revision.create(revisable: self, metadata: metadata)
  end
end