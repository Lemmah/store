class Wishlists::WishlistProductsController < ApplicationController
  before_action :set_wishlist
  before_action :set_wishlist_product

  def destroy
    Rails.logger.debug params.inspect
    @wishlist_product.destroy
    redirect_to @wishlist, status: :see_other,
      notice: "#{@wishlist_product.product.name} removed from wishlist."
  end

  private

  def set_wishlist
    @wishlist = Current.user.wishlists.find(params[:wishlist_id])
  end

  def set_wishlist_product
    @wishlist_product = @wishlist.wishlist_products.find(params[:id])
  end
end
