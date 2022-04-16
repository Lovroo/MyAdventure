class AddUserId < ActiveRecord::Migration[6.1]
  def change
    add_column :fav_categories, :user_id, :integer
    add_index :fav_categories, :user_id
    add_foreign_key :fav_categories, :users, on_delete: :cascade
  end
end
