class Products::ReviewsController < ApplicationController
  def index
    @reviews = Review.includes(:user).where(product_id: params[:product_id])
  end

  def new
    @review = Current.user.reviews.new(product_id: params[:product_id])
  end

  def create
    @review = Current.user.reviews.new(reviews_params)
    if @review.save
      redirect_to product_path(reviews_params[:review][:product_id]),
        status: :see_other
    else
      render :create, status: :unprocessable_entity,
        alert: "Review could not be saved."
    end
  end

  private

  def reviews_params
    params.expect(review: [ :product_id, :star_rating ])
  end
end
