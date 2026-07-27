class Products::ReviewsController < ApplicationController
  allow_unauthenticated_access only: [ :index ]
  before_action :set_product
  def index
    @reviews = @product.reviews.includes(:user).newest_first
  end

  def new
    @review = @product.reviews.new
  end

  def create
    @review = @product.reviews.new(review_params)
    if @review.save
      redirect_to product_reviews_path(@product),
        status: :see_other, notice: "Review saved successfully."
    else
      flash[:alert].now = "Review could not be saved."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.expect(review: [ :star_rating, :comment, images: [] ])
          .with_defaults(user: Current.user)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
