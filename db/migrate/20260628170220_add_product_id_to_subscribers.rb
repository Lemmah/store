class AddProductIdToSubscribers < ActiveRecord::Migration[8.1]
  def change
    add_column :subscribers, :product_id, :integer
  end
end
