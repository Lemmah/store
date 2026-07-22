class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  has_rich_text :comment
end
