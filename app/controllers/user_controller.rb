class UserController < Devise::UserController
  def index
    @user = User.all
    @destinations = FavDestination.where(user_id: @user.id).where(visited: false).limit(3)
  end
end
