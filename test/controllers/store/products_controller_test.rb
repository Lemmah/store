require "test_helper"

class Store::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "non-admin cannot access /store/products index" do
    sign_in_as users(:one)
    get store_products_path
    assert_redirected_to root_path
    assert_equal "You are not allowed to do that.", flash[:alert]
  end

  test "admin can access /store/products index" do
    sign_in_as users(:admin)
    get store_products_path
    assert_response :success
    assert_dom "a", "New Product"
  end

  test "admin can access new product page" do
    sign_in_as users(:admin)
    get new_store_product_path
    assert_response :success
    assert_dom "form"
  end

  test "admin can view a product" do
    sign_in_as users(:admin)
    product = products(:tshirt)
    get store_product_path(product)
    assert_response :success
    assert_dom "h1", product.name
  end

  test "non-admin cannot create new product" do
    sign_in_as users(:one)
    assert_no_difference "Product.count" do
      post store_products_path, params: {
        product: {
          name: "Test Product"
        }
      }
    end
    assert_redirected_to root_path
    assert_equal "You are not allowed to do that.", flash[:alert]
  end

  test "admin can create new product" do
    sign_in_as users(:admin)
    assert_difference "Product.count" do
      post store_products_path, params: {
        product: {
          name: "Test Product"
        }
      }
    end
    product = Product.find_by!(name: "Test Product")
    assert_redirected_to store_product_path(product)
  end

  test "admin cannot create invalid product" do
    sign_in_as users(:admin)

    assert_no_difference "Product.count" do
      post store_products_path, params: {
        product: {
          name: ""
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "admin can update product details" do
    sign_in_as users(:admin)
    product = products(:short)

    put store_product_path(product), params: {
      product: {
        inventory_count: 20
      }
    }

    assert_equal 20, product.reload.inventory_count
    assert_redirected_to store_product_path(product)
  end

  test "admin cannot update product with invalid details" do
    sign_in_as users(:admin)
    product = products(:short)
    original_inventory_count = product.inventory_count

    put store_product_path(product), params: {
      product: {
        inventory_count: -2
      }
    }

    assert_response :unprocessable_entity
    assert_equal original_inventory_count, product.reload.inventory_count
  end

  test "admin can delete a product" do
    sign_in_as users(:admin)
    product = products(:short)

    assert_difference "Product.count", -1 do
      delete store_product_path(product)
    end
    assert_not Product.exists?(product.id)
    assert_redirected_to store_products_path
  end

  test "non-admin cannot delete a product" do
    sign_in_as users(:one)
    product = products(:short)

    assert_no_difference "Product.count" do
      delete store_product_path(product)
    end
    assert Product.exists?(product.id)
    assert_redirected_to root_path
    assert_equal "You are not allowed to do that.", flash[:alert]
  end
end
