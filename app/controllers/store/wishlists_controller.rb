class Store::WishlistsController < Store::BaseController
  def index
    @wishlists = Wishlist.includes(:user).all
    @wishlists = @wishlists.where(user_id: params[:user_id]) if params[:user_id].present?
    @wishlists = @wishlists.includes(:wishlist_products).where(
      wishlist_products: { product_id: params[:product_id] }
    ) if params[:product_id].present?
  end

  def show
    @wishlist = Wishlist.includes(:products).find_by(id: params[:id])
  end
end
