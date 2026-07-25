class AddStarRatingsSumToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :star_ratings_sum, :decimal, precision: 2, scale: 1, default: 0.0
  end
end
