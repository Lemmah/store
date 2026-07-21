class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true
      t.integer :star_rating

      t.timestamps
    end
  end
end
