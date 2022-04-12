class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def new
  end
  def index
    @favorites = FavDestination.where(user_id: current_user.id)
    if params[:category_name]
      @favorites = FavDestination.where("category LIKE ?", "%" + params[:category_name] + "%").where(user_id: current_user.id)
    else
      @favorites = FavDestination.where(user_id: current_user.id)
    end
  end
  def destroy
    FavDestination.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to favorites_url, notice: "Destination was removed." }
      format.json { head :no_content }
    end
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
      name_of_place = json['name']

    if FavDestination.where(user_id: current_user.id).where( name: name_of_place).exists?
      respond_to do |format|
        format.html { redirect_to favorites_url, notice: "Destination already exists." }
        format.json { head :no_content }
      end
    else
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
      respond_to do |format|
        format.html { redirect_to favorites_url, notice: "Destination was added." }
        format.json { head :no_content }
      end
    end
    end
  end
  end
