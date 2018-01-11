module Revisable
  extend ActiveSupport::Concern

  included do
    def self.revisable
      has_many :revisions, as: :revisable
      after_save :create_revision
    end

    def create_revision
      Revision.create(revisable: self, metadata: self.to_json(except: [:id, :created_at, :updated_at]))
    end
  end
end
