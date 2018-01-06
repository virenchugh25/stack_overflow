class Session < ApplicationRecord
  validates_presence_of :user, :auth_token

  belongs_to :user

  scope :active, -> { where(deleted_at: nil) }
end
