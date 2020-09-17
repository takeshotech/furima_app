Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:index, :edit, :update]
  root 'home#index'
  resources :products, only: [:new, :create, :show] do
      collection do
      get 'get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
      
      resources :orders, only: [:show, :create]
    end
  end
  

  resources :credit_cards, only: [:new, :create, :show, :destroy] 
end
  