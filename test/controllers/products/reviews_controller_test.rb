require "test_helper"

class Products::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get products_reviews_create_url
    assert_response :success
  end
end
