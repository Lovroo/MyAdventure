class FavoritesImportsController < ApplicationController
  before_action :authenticate_user!
  def new
    @favorites_import = FavoritesImport.new
  end

  def create
    @favorites_import = FavoritesImport.new(params[:items_import])
    if @favorites_import.save
      redirect_to favorites_path, notice: "Visited destinations imported."
    else
      render :new
    end
  end
end