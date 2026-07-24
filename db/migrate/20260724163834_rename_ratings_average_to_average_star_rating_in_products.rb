class RenameRatingsAverageToAverageStarRatingInProducts < ActiveRecord::Migration[8.1]
  def change
    rename_column :products, :ratings_average, :average_star_rating
  end
end
