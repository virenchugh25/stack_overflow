class Session < ApplicationRecord
  validates_presence_of :user, :auth_token
  validates_uniqueness_of :auth_token

  belongs_to :user

  ignore_soft_deleted
end
