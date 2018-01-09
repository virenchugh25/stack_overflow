class Session < ApplicationRecord
  validates_presence_of :user, :auth_token

  belongs_to :user

  default_scope { where(deleted_at: nil) }
end
