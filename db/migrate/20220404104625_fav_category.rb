class FavCategory < ActiveRecord::Migration[6.1]
  def change
    create_table :fav_categories do |t|
      t.timestamps
    end
  end
end
