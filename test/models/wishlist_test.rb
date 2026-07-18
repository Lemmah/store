require "test_helper"

class WishlistTest < ActiveSupport::TestCase
  test "filter with no filters" do
    assert_equal Wishlist.all, Wishlist.filter_by({})
  end

  test "filter with user_id" do
    wishlists = Wishlist.filter_by({ user_id: users(:one).id })
    assert_equal 1, wishlists.count
    assert_includes wishlists, wishlists(:one)
    assert_not_includes wishlists, wishlists(:two)
  end

  test "filter with product_id" do
    wishlists = Wishlist.filter_by({ product_id: products(:shoes).id })
    assert_equal 1, wishlists.count
    assert_includes wishlists, wishlists(:two)
    assert_not_includes wishlists, wishlists(:one)
  end
end
