class FavDestination < ApplicationRecord
  validates_presence_of :name, :description, :image, :country, :lat, :lat, :user_id
end
