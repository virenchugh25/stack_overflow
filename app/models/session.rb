class Session < ApplicationRecord
  validates_presence_of :user, :auth_token

  belongs_to :user

  ignore_soft_deleted
end
