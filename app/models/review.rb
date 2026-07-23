class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product, counter_cache: true

  scope :newest_first, -> { order(created_at: :desc) }
end
