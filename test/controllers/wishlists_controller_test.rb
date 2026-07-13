require "test_helper"

class WishlistsControllerTest < ActionDispatch::IntegrationTest
  test "shows wishlists on index" do
    sign_in_as users(:one)
    get wishlists_path
    assert_response :success
    assert_dom "li", text: wishlists(:one).name
    assert_dom "a[href='#{new_wishlist_path}']"
  end

  test "user can create a wishlist" do
    user = users(:one)
    sign_in_as user

    assert_difference -> { user.wishlists.count }, 1 do
      post wishlists_path, params: {
        wishlist: {
          name: "Test Wishlist 123"
        }
      }
    end

    wishlist = user.wishlists.find_by!(name: "Test Wishlist 123")
    assert_redirected_to wishlist_path(wishlist)
    assert_equal "Your wishlist was created successfully.", flash[:notice]
  end

  test "user can edit a wishlist" do
    user = users(:one)
    sign_in_as user
    wishlist = user.wishlists.first
    previous_wishlist_name = wishlist.name
    put wishlist_path(wishlist), params: {
      wishlist: {
        name: "Updated Wishlist Test"
      }
    }
    wishlist.reload
    refute_equal previous_wishlist_name, wishlist.name
    assert_equal "Updated Wishlist Test", wishlist.name
    assert_redirected_to wishlist_path(wishlist)
    assert_equal "Your wishlist has been updated successfully.", flash[:notice]
  end
end
