require "test_helper"

class Products::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should list reviews for a product on index" do
    sign_in_as users(:one)
    get product_reviews_path(products(:tshirt))
    assert_response :success
  end
end
