class Tag < ApplicationRecord
  has_and_belongs_to_many :questions
  validates :name, presence: true, length: { maximum: 30, too_long: "%{count} is the maximum characters allowed" }
end
