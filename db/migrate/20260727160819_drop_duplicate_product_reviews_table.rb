class DropDuplicateProductReviewsTable < ActiveRecord::Migration[8.1]
  def change
    drop_table :product_reviews
  end
end
