Rails.application.routes.draw do

  devise_for :users
  root 'home#index'
  resources :users, only: [:index, :edit, :update, :show]
  resources :products, only: [:index, :new, :create, :show] do
    collection do
      get 'get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
      
      resources :orders, only: [:show, :create]
    end
  end
  
  resources :categories, only: [:index, :new, :show]

  resources :credit_cards, only: [:new, :create, :show, :destroy] 
end
  