class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  scope :newest_first, -> { order(created_at: :desc) }
end
