class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product, counter_cache: true

  scope :newest_first, -> { order(created_at: :desc) }

  after_commit :calculate_average_star_rating,
    on: %i[ create update destroy ]

  private

  def calculate_average_star_rating
    return if transaction_include_any_action?([ :update ]) &&
      !saved_change_to_star_rating?

    product.update!(
      average_star_rating: product.reviews.average(:star_rating) || 0
    )
  end
end
