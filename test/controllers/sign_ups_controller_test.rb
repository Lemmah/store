require "test_helper"

class SignUpsControllerTest < ActionDispatch::IntegrationTest
  test "view sign up" do
    get sign_up_path
    assert_response :success
  end

  test "view sign up when authenticated" do
    sign_in_as users(:one)
    get sign_up_path
    assert_redirected_to root_path
  end

  test "successful sign up" do
    assert_difference "User.count" do
      post sign_up_path, params: { user:
        { first_name: "Example",
          last_name: "User",
          email_address: "user@example.com",
          password: "password",
          password_confirm: "password"
        }
      }
      assert_redirected_to root_path
    end
  end

  test "invalid sign up" do
    assert_no_difference "User.count" do
      post sign_up_path, params: {
        user: {
          email_address: "user@example.com",
          password: "password",
          password_confirm: "password"
        }
      }
      assert_response :unprocessable_entity
    end
  end

  test "sign up ignores admin attribute" do
    assert_difference "User.count" do
      post sign_up_path, params: {
        user: {
          first_name: "Example",
          last_name: "User",
          email_address: "user@example.com",
          password: "password",
          password_confirm: "password",
          admin: true
        }
      }

      assert_redirected_to root_path
      refute User.find_by(email_address: "user@example.com").admin?
    end
  end
end
