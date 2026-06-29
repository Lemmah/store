require "test_helper"

class ProductMailerTest < ActionMailer::TestCase
  test "in_stock" do
    product = products(:tshirt)
    subscriber = subscribers(:lemmah)

    mail = ProductMailer.with(
      product: product,
      subscriber: subscriber
    ).in_stock

    assert_equal "Product back in stock!", mail.subject
    assert_equal [ "test@lemmah.test" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "back in stock", mail.subject
    assert_match "Good news!", mail.body.encoded
    assert_match "#{product.name}", mail.body.encoded
    assert_match "Unsubscribe", mail.body.encoded
  end
end
