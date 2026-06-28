class AddConstraintsToSubscribersProduct < ActiveRecord::Migration[8.1]
  def change
    add_foreign_key :subscribers, :products
    change_column_null :subscribers, :product_id, false
  end
end
