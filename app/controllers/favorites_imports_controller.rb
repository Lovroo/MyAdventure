class FavoritesImportsController < ApplicationController
  before_action :authenticate_user!
  def new
    @favorites_import = FavDestination.new
  end

  def create
    @favorites_import = FavDestination.new(params[:file])
    if @favorites_import.save
      redirect_to favorites_path, notice: "Visited destinations imported."
    else
      render :new
    end
  end
end