require "test_helper"

class SubscriberTest < ActiveSupport::TestCase
  test "filter_by with no filters returns all subscribers" do
    assert_equal subscribers.to_set, Subscriber.filter_by({}).to_set
  end

  test "filter_by orders by created_at in descending" do
    expected = [
      subscribers(:lemmah),
      subscribers(:bern),
      subscribers(:joe)
    ]
    assert_equal expected, Subscriber.filter_by({})
  end

  test "filter with product_id returns only subscribers for that product" do
    product = products(:short)
    expected = [ subscribers(:joe) ]
    assert_equal expected, Subscriber.filter_by({ product_id: product.id })
  end
end
