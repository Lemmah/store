class Products::ReviewsController < ApplicationController
  def index
    @reviews = Review.includes(:user)
                .order(created_at: :desc)
                .where(product_id: params[:product_id])
  end

  def new
    @review = Current.user.reviews.new(product_id: params[:product_id])
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = Current.user
    if @review.save
      redirect_to product_reviews_path(params[:product_id]),
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
end
