Rails.application.routes.draw do
  root to: 'recipes#index'
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update] do
    post 'feature', to: 'recipes#featured', on: :member
  end
  resources :recipe_types, only: [:new, :create, :show]
  resources :cuisines, only: [:show, :new, :create]
end
