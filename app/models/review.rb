class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product, counter_cache: true

  scope :newest_first, -> { order(created_at: :desc) }

  after_commit :recalculate_average_star_rating,
    on: %i[ create update destroy ]

  private

  def recalculate_average_star_rating
    return if transaction_include_any_action?([ :update ]) &&
      !saved_change_to_star_rating?

    product.recalculate_average_star_rating!
  end
end
