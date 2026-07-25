class RemoveAverageStarRatingFromProduct < ActiveRecord::Migration[8.1]
  def change
    remove_column :products, :average_star_rating
  end
end
