require "test_helper"

class Products::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should list reviews for a product on index" do
    sign_in_as users(:one)
    get product_reviews_path(products(:tshirt))
    assert_response :success
    assert_dom "h1", text: "1 review for T-Shirt"
  end
end
