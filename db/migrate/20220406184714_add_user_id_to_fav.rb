class AddUserIdToFav < ActiveRecord::Migration[6.1]
  def change
    add_index :fav_destinations, :user_id
    add_foreign_key :fav_destinations, :users
  end
end
