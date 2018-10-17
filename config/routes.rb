Rails.application.routes.draw do
  root 'posts#index'
  resources :tags
  resources :posts
  resources :categories
end
