require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "email_confirmation" do
    user = users(:one)
    user.update_column(:unconfirmed_email, "new-email@example.com")
    mail = UserMailer.with(user: user).email_confirmation
    assert_equal "Email confirmation", mail.subject
    assert_equal [ user.unconfirmed_email ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Confirm your email", mail.body.encoded
  end
end
