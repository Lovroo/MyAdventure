class CreateFavDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :fav_destinations do |t|
      t.string :name
      t.string :town
      t.string :country
      t.string :suburb
      t.string :image
      t.string :description
      t.integer :user_id
      t.string :category
      t.string :lat
      t.string :lon
      t.timestamps
    end
  end
end
