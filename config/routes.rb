Rails.application.routes.draw do
  get 'category_select/CategorySelect'
  devise_for :users
  root to: 'pages#home'
end
