class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def new
  end
  def index
    @favorites = FavDestination.where(user_id: current_user.id)
  end

  def create
    require 'net/http'
    require 'json'
    if params[:id]
      xid = params[:id]
      # get JSON
      result = Net::HTTP.get(URI.parse('https://api.opentripmap.com/0.1/en/places/xid/'+ xid + '?apikey=5ae2e3f221c38a28845f05b63491fa7c34e2bf26d286b76a8e47f69d'))

      # parse JSON
      json = JSON.parse(result)

      # save data to DB
        FavDestination.create(
          user_id: current_user.id,
          name: json['name'],
          image: json['preview']['source'],
          category: json['kinds'],
          suburb: json['address']['suburb'],
          description: json['wikipedia_extracts']['html'],
          country: json['address']['country'],
          town: json['address']['town'],
          lat: json['point']['lat'],
          lon: json['point']['lon'],
          )
      end
  end
end
