class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :surname, :avatar, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :surname, :avatar, :email, :password, :current_password])
  end
  def after_sign_up_path_for(resource)
    cat_select_category_select_path# <- Path you want to redirect the user to.
  end
end
