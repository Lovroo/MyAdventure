class FavDestination < ApplicationRecord
  validates_presence_of :name, :description, :image_url, :country, :lat, :lat, :user_id
end
