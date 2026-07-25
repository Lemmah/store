class Product < ApplicationRecord
  include Notifications

  has_one_attached :featured_image
  has_rich_text :description
  has_many :wishlist_products, dependent: :destroy
  has_many :wishlists, through: :wishlist_products
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :inventory_count, numericality: { greater_than_or_equal_to: 0 }

  def average_star_rating
    (star_ratings_sum / reviews_count).round(1)
  end

  def reset_star_ratings_sum
    update!(star_ratings_sum: reviews.sum(:star_rating))
  end
end
