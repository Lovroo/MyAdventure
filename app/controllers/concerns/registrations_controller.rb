class RegistrationsController < Devise::RegistrationsController
  protected
  def after_sign_up_path_for(resource)
    '/categories_select/category_select'
  end
end