class CategoriesSelectController < ApplicationController
  before_action :authenticate_user!
    def index
      @categories = Categories.all
    end
      def create
        @FavCategory = FavCategory.new()
        @FavCategory.user_id = current_user
        render json: response
      end
    end