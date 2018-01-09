class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_secure_password  

  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email

  has_many :questions
  has_many :answers
  has_many :sessions
  has_many :votes
  has_many :comments
  
  before_save { email.downcase! }

  default_scope { where(deleted_at: nil) }
end
