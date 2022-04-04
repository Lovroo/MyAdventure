class AddCategoryIdToFavCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :fav_categories, :category_id, :integer
    add_index :fav_categories, :category_id
    add_foreign_key :fav_categories, :categories
  end
end
