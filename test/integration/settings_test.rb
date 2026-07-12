class SettingsTest < ActionDispatch::IntegrationTest
  test "user settings nav" do
    sign_in_as users(:one)
    get settings_profile_path
    assert_dom "h4", "Account Settings"
    assert_not_dom "h4", "Store Settings"
  end

  test "admin settings nav" do
    sign_in_as users(:admin)
    get settings_profile_path
    assert_dom "h4", "Account Settings"
    assert_dom "h4", "Store Settings"
  end

  test "regular users cannot access /store/products" do
    sign_in_as users(:one)
    get store_products_path
    assert_response :redirect
    assert_equal "You are not allowed to do that.", flash[:alert]
  end

  test "regular users cannot access /store/users" do
    sign_in_as users(:one)
    get store_products_path
    assert_response :redirect
    assert_equal "You are not allowed to do that.", flash[:alert]
  end

  test "admin users can access /store/products" do
    sign_in_as users(:admin)
    get store_products_path
    assert_response :success
  end

  test "admin users can access /store/users" do
    sign_in_as users(:admin)
    get store_products_path
    assert_response :success
  end
end
