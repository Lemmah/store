class Store::WishlistsController < Store::BaseController
  def index
    @wishlists = Wishlist.includes(:user).all
  end

  def show
    @wishlist = Wishlist.find_by(id: params[:id])
  end
end
