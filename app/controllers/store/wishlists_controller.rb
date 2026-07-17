class Store::WishlistsController < Store::BaseController
  def index
    @wishlists = Wishlist.includes(:user).all
  end

  def show
    @wishlist = Wishlist.includes(:products).find_by(id: params[:id])
  end
end
