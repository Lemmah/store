class WishlistsTest < ActionDispatch::IntegrationTest
  test "create a wishlist" do
    user = users(:one)
    sign_in_as user
    assert_difference -> { user.wishlists.count }, 1 do
      post wishlists_path, params: {
        wishlist: {
          name: "New Test Wishlist"
        }
      }
    end
    wishlist = user.wishlists.find_by(name: "New Test Wishlist")
    assert_redirected_to wishlist_path(wishlist)
    assert_equal "Your wishlist was created successfully.", flash[:notice]
  end

  test "delete a wishlist" do
    user = users(:one)
    sign_in_as user
    assert_difference -> { user.wishlists.count }, -1 do
      delete wishlist_path(user.wishlists.first)
    end
    assert_redirected_to wishlists_path
  end

  test "view a wishlist" do
    user = users(:one)
    sign_in_as user
    wishlist = user.wishlists.first
    get wishlist_path(wishlist)
    assert_response :success
    assert_dom "h1", text: wishlist.name
  end

  test "view a wishlist as another user" do
    wishlist = users(:two).wishlists.first
    sign_in_as users(:one)
    get wishlist_path(wishlist)
    assert_response :success
    assert_dom "h1", text: wishlist.name
  end

  test "add product to a specific wishlist" do
    user = users(:one)
    wishlist = user.wishlists.first
    product = products(:one)
    sign_in_as user
    assert_difference -> { WishlistProduct.count }, 1 do
      post product_wishlist_path(product), params: {
        wishlist_id: wishlist.id
      }
    end
    assert_includes wishlist.reload.products, product
    assert_redirected_to wishlist
  end

  test "add product when no wishlists" do
    user = users(:one)
    product = products(:one)
    user.wishlists.destroy_all
    sign_in_as user
    assert_difference [ "Wishlist.count", "WishlistProduct.count" ], 1 do
      post product_wishlist_path(product)
    end
    wishlist = user.wishlists.reload.last
    assert_includes wishlist.products, product
  end

  test "cannot add product to another user's wishlist" do
    sign_in_as users(:one)
    wishlist = users(:two).wishlists.first
    assert_no_difference "WishlistProduct.count" do
      post product_wishlist_path(products(:one)), params: {
        wishlist_id: wishlist.id
      }
    end
    assert_response :not_found
  end

  test "move product to another wishlist" do
    user = users(:one)
    sign_in_as user
    wishlist = user.wishlists.first
    wishlist_product = wishlist.wishlist_products.first
    second_wishlist = user.wishlists.create(name: "Second Wishlist")
    patch wishlist_wishlist_product_path(wishlist, wishlist_product), params: {
      new_wishlist_id: second_wishlist.id
    }
    assert_equal second_wishlist, wishlist_product.reload.wishlist
  end

  test "cannot move product to wishlist that already contains product" do
    user = users(:one)
    sign_in_as user
    wishlist = user.wishlists.first
    wishlist_product = wishlist.wishlist_products.first
    second_wishlist = user.wishlists.create!(name: "Second Wishlist")
    second_wishlist.wishlist_products.create!(product_id: wishlist_product.product_id)
    assert_no_difference -> { second_wishlist.wishlist_products.count } do
      patch wishlist_wishlist_product_path(wishlist, wishlist_product), params: {
        new_wishlist_id: second_wishlist.id
      }
      assert_redirected_to wishlist
    end
    assert_equal wishlist, wishlist_product.wishlist
  end

  test "cannot move product to another user's wishlist" do
    user = users(:one)
    sign_in_as user
    wishlist = user.wishlists.first
    wishlist_product = wishlist.wishlist_products.first
    other_wishlist = users(:two).wishlists.first
    patch wishlist_wishlist_product_path(wishlist, wishlist_product), params: {
      new_wishlist_id: other_wishlist.id
    }
    assert_response :not_found
    assert_equal wishlist, wishlist_product.reload.wishlist
  end
end
