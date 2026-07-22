class Products::ReviewsController < ApplicationController
  before_action :set_product
  def index
    @reviews = @product.reviews.includes(:user).newest_first
  end

  def new
    @review = @product.reviews.new
  end

  def create
    @review = @product.reviews.new(review_params)
    @review.user = Current.user
    if @review.save
      redirect_to product_reviews_path(@product),
        status: :see_other
    else
      render :new, status: :unprocessable_entity,
        alert: "Review could not be saved."
    end
  end

  private

  def review_params
    params.expect(review: [ :star_rating, :comment ])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
