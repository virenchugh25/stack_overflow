class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 30, too_long: "%{count} is the maximum characters allowed" }

  has_and_belongs_to_many :questions

  ignore_soft_deleted
end
