class RegistrationsController < Devise::RegistrationsController
  protected
  skip_before_filter :verify_authenticity_token, :only => :create
  def after_sign_up_path_for(resource)
    '/categories_select/category_select'
  end
end