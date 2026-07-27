class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product, counter_cache: true
  has_many_attached :images

  validates :star_rating, presence: true, numericality: { in: 1..5, only_integer: true }

  scope :newest_first, -> { order(created_at: :desc) }

  after_create_commit :increment_product_star_ratings_sum
  after_destroy_commit :decrement_product_star_ratings_sum
  after_update_commit :update_product_star_ratings_sum,
    if: :saved_change_to_star_rating?

  private

  def increment_product_star_ratings_sum
    product.increment!(:star_ratings_sum, star_rating)
  end

  def decrement_product_star_ratings_sum
    product.decrement!(:star_ratings_sum, star_rating)
  end

  def update_product_star_ratings_sum
    product.increment!(:star_ratings_sum, star_rating - star_rating_previously_was.to_f)
  end
end
