require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  setup do
    @product = products(:one)
    @user = users(:one)
  end

  test "creating a review increases product star ratings sum" do
    assert_difference -> { @product.reload.star_ratings_sum }, 4 do
      @product.reviews.create!(
        user: @user,
        star_rating: 4
      )
    end
  end

  test "destroying a review decreases product star ratings sum" do
    review = @product.reviews.new(
      user: @user,
      star_rating: 5
    )
    review.save!
    assert_difference -> { @product.reload.star_ratings_sum }, -5 do
      review.destroy!
    end
  end

  test "decreasing a review rating decreases product star ratings sum" do
    review = @product.reviews.new(
      user: @user,
      star_rating: 5
    )
    review.save!
    assert_difference -> { @product.reload.star_ratings_sum }, -2 do
      review.update!(star_rating: 3)
    end
  end

  test "increasing a review rating increases product star ratings sum" do
    review = @product.reviews.new(
      user: @user,
      star_rating: 3
    )
    review.save!
    assert_difference -> { @product.reload.star_ratings_sum }, 2 do
      review.update(star_rating: 5)
    end
  end
end
