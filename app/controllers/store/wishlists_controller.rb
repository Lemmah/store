class Store::WishlistsController < Store::BaseController
  def index
    @wishlists = Wishlist.filter_by(params)
  end

  def show
    @wishlist = Wishlist.includes(:products).find_by(id: params[:id])
  end
end
