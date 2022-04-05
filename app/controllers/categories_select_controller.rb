class CategoriesSelectController < ApplicationController
before_action :authenticate_user!
before_action :noAccess!
  def index
    @categories = Categories.all
  end
  def create
    @FavCategory = params[:cat_params]
    @FavCategory.each do |c|
      @FavCategory = FavCategory.new(c)
    @FavCategory.user_id = current_user.id
    respond_to do |format|
      if @FavCategory.save
        format.json { render :show, status: :created, location: @FavCategory }
      else
        format.json { render json: @FavCategory.errors, status: :unprocessable_entity }
      end
    end
    end
  end
  def FavCategory
    @FavCategory = self.FavCategory
  end
  def new
    @FavCategory = FavCategory.new
  end
private
def cat_params
  params.permit(:category_id)
end
def noAccess!
  if(current_user.fav_categories.count > 1)
    redirect_to root_path
  end
end
end