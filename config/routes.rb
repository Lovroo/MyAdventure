Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'favorites/new'
  get 'favorites/create'
  get 'categories_select/category_select'
  devise_for :users
  root :to => 'pages#home'
  post 'categories_select/category_select', to:  'categories_select#create'
  get 'favorites', to: 'favorites#index'
  delete 'favorites', to: 'favorites#destroy'
end
