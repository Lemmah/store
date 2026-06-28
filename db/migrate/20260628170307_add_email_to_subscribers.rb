class AddEmailToSubscribers < ActiveRecord::Migration[8.1]
  def change
    add_column :subscribers, :email, :string
  end
end
