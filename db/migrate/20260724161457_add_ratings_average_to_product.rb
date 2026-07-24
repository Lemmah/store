class AddRatingsAverageToProduct < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :ratings_average, :decimal, precision: 2, scale: 1, default: 0.0
  end
end
