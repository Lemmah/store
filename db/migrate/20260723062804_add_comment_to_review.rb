class AddCommentToReview < ActiveRecord::Migration[8.1]
  def change
    add_column :reviews, :comment, :string
  end
end
