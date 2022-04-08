Rails.application.routes.draw do
  get 'favorites/new'
  get 'favorites/create'
  get 'categories_select/category_select'
  devise_for :users
  root :to => 'pages#home'
  post 'categories_select/category_select', to:  'categories_select#create'
end
