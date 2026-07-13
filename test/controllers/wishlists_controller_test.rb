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
end
