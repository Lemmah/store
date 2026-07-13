class WishlistsController < ApplicationController
  allow_unauthenticated_access only: [ :show ]
  def index
    @wishlists = Current.user.wishlists
  end

  def show
    @wishlist = Wishlist.find(params[:id])
  end

  def new
    @wishlist = Wishlist.new
  end

  def create
    @wishlist = Current.user.wishlists.new(wishlist_params)
    if @wishlist.save
      redirect_to @wishlist, notice: "Your wishlist was created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def wishlist_params
    params.expect(wishlist: [ :name ])
  end

  def set_wishlist
  end
end
