Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'

  resources :recipes do
    post 'feature', to: 'recipes#featured', on: :member
  end
  
  resources :recipe_types, only: [:new, :create, :show]
  resources :cuisines, only: [:show, :new, :create]
end
