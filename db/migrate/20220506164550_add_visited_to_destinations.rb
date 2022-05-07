class AddVisitedToDestinations < ActiveRecord::Migration[6.1]
  def change
    add_column :fav_destinations, :visited, :boolean
  end
end
